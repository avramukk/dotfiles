import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const STATUS_KEY = "session-name";

export default function (pi: ExtensionAPI) {
	const updateSessionStatus = (ctx: ExtensionContext) => {
		const name = pi.getSessionName();
		ctx.ui.setStatus(
			STATUS_KEY,
			name ? ctx.ui.theme.fg("accent", name) : undefined,
		);
	};

	pi.on("session_start", async (_event, ctx) => {
		updateSessionStatus(ctx);
	});

	pi.on("session_info_changed", async (_event, ctx) => {
		updateSessionStatus(ctx);
	});
}
