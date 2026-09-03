#!/usr/bin/env python3
"""Execute run_set.sh shiori tags set commands with rate-limit safety."""
import re, subprocess, time, sys, os

DATA = os.environ.get("SHIORI_TAG_DATA", os.path.expanduser("~/shiori-tag-work"))
os.chdir(DATA)
PATH = os.environ.get("PATH", "")
os.environ["PATH"] = os.path.expanduser("~/.local/bin") + ":" + PATH

CMD = re.compile(r"^shiori tags set (\S+) (.+)$")

def run(args, n=12):
    for i in range(n):
        p = subprocess.run(args, capture_output=True, text=True)
        out = (p.stdout or "") + (p.stderr or "")
        low = out.lower()
        if p.returncode != 0:
            if "too many requests" in low or "429" in low:
                time.sleep(min(8, 3 + i))   # backoff on rate limit
                continue
            return ("err", out.strip())
        if "tags not found" in low:
            return ("missing", out.strip())
        return ("ok", out.strip())
    return ("fail_after_retries", out.strip())

def ensure_tags(tagstr):
    for t in tagstr.split(","):
        t = t.strip()
        if not t:
            continue
        # create idempotently; "already exists" / success is fine
        for _ in range(10):
            rr = subprocess.run(["shiori", "tags", "create", t], capture_output=True, text=True)
            o = (rr.stdout or "") + (rr.stderr or "")
            ol = o.lower()
            if rr.returncode == 0 or "already exists" in ol or "already" in ol:
                break
            if "too many requests" in ol or "429" in ol:
                time.sleep(4)
                continue

def main():
    lines = [l for l in open("run_set.sh") if l.strip()]
    total = len(lines)
    ok = 0; failed = 0; missing_created = 0
    failed_path = "failed.txt"
    log_path = "executor.log"
    fl = open(failed_path, "a")
    log = open(log_path, "a")
    for idx, line in enumerate(lines, 1):
        m = CMD.match(line.strip())
        if not m:
            continue
        link_id, tagstr = m.group(1), m.group(2)
        status, msg = run(["shiori", "tags", "set", link_id, tagstr])
        if status == "missing":
            # create missing tags, then retry
            ensure_tags(tagstr)
            missing_created += 1
            status, msg = run(["shiori", "tags", "set", link_id, tagstr])
        if status == "ok":
            ok += 1
        else:
            failed += 1
            fl.write(f"{line.strip()}  # {status}: {msg[:120]}\n")
            fl.flush()
        if idx % 25 == 0 or idx == total:
            log.write(f"progress {idx}/{total} ok={ok} failed={failed} missing_created={missing_created}\n")
            log.flush()
        time.sleep(1.2)   # respect ~50/min rate limit
    log.write(f"FINISHED total={total} ok={ok} failed={failed} missing_created={missing_created}\n")
    log.flush()
    fl.close()
    log.close()
    print(f"DONE total={total} ok={ok} failed={failed} missing_created={missing_created}")

if __name__ == "__main__":
    main()