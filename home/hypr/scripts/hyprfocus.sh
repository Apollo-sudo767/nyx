!/bin/env bash

CONFIG="$HOME/.config/hypr/template_hyprland.conf"

# Check the current mod and toggle it
if grep -q "main_mod=Alt" "$CONFIG"; then
  # If Alt is set, switch to Super
  sed -i "s/main_mod=Alt/main_mod=Super/" "$CONFIG"
  echo "Switched to Super key"
else
  # If Super is set, switch to Alt
  sed -i "s/main_mod=Super/main_mod=Alt/" "$CONFIG"
  echo "Switched to Alt key"
fi

# Apply the changes by running home-manager
home-manager switch

