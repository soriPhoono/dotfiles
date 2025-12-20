{
  lib,
  inputs,
  namespace,
  ...
}: {
  ${namespace} = {
    wallpaper = name: "../assets/wallpapers/${name}";
  };
}
