{
	stdenv,
	zig_0_16,
	fetchFromGitHub,
	lib,
}: let
	zig = zig_0_16;
in
	stdenv.mkDerivation (finalAttrs: {
			pname = "zlob";
			version = "1.6.5";
			src =
				fetchFromGitHub {
					owner = "dmtrKovalenko";
					repo = "zlob";
					rev = "v${finalAttrs.version}";
					hash = "sha256-1NigJyn2WcbBD+w0quPigtFrcX0eNpImHPRil9iptpI=";
				};

			zigDeps =
				zig.fetchDeps {
					inherit (finalAttrs) src pname version;
					fetchAll = true;
					hash = "sha256-rOsFulT8MvLIB5UEySl2biLoyMxTUCVbWbIkz4pZ/go=";
				};

			postConfigure = ''
				ln -s ${finalAttrs.zigDeps} "$ZIG_GLOBAL_CACHE_DIR/p"
			'';

			nativeBuildInputs = [
				zig
			];
		})
