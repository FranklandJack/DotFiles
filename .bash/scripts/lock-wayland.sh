#!/usr/bin/env bash
# This script is a cutom wrapper for swaylock
# Dependencies: swaylock, convert, grim.

for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
  # Create a temporary file to work with.
  IMAGE="$(mktemp).png"

  # Take a screenshot and save it to the temporary file.
  grim -o ${OUTPUT} "$IMAGE"

  # Transform the image.
  PIXELATE=(-scale 10% -scale 1000%)
  PAINT=(-paint 0.0025)
  convert "$IMAGE" "${HUE[@]}"  "${PIXELATE[@]}" "$IMAGE"
  LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
done
#
# Call the sway lock.
swaylock $LOCKARGS -u
