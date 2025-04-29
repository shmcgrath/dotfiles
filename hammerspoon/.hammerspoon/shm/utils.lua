local utils = {}

function utils.hide_app(appName)
  local app = hs.application.get(appName)
  if app then
    app:hide()
  end
end

function utils.focus_or_launch_app(appName)
  local app = hs.application.get(appName)
  if app then
    app:activate()
  else
    hs.application.launchOrFocus(appName)
  end
end

function utils.toggle_app(appName)
  local app = hs.application.get(appName)
  if app then
    if app:isFrontmost() then
      app:hide()
    else
      utils.focus_or_launch_app(appName)
    end
  else
    utils.focus_or_launch_app(appName)
  end
end

return utils
