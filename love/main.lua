local ScreenManager = require('lib.screenmanager.ScreenManager');

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

local showDebug = false;

-- ------------------------------------------------
-- Local Functions
-- ------------------------------------------------

local function drawStats()
    love.graphics.setColor(100, 100, 100, 255);
    love.graphics.rectangle('fill', 5, love.graphics.getHeight() - 185, 200, 200);
    love.graphics.setColor(255, 255, 255, 255);
    love.graphics.print(string.format("FT: %.3f ms", 1000 * love.timer.getAverageDelta()), 10, love.graphics.getHeight() - 180);
    love.graphics.print(string.format("FPS: %.3f fps", love.timer.getFPS()), 10, love.graphics.getHeight() - 160);
    love.graphics.print(string.format("MEM: %.3f kb", collectgarbage("count")), 10, love.graphics.getHeight() - 140);

    local stats = love.graphics.getStats();
    love.graphics.print(string.format("Drawcalls: %d", stats.drawcalls), 10, love.graphics.getHeight() - 120);
    love.graphics.print(string.format("Canvas Switches: %d", stats.canvasswitches), 10, love.graphics.getHeight() - 100);
    love.graphics.print(string.format("TextureMemory: %.2f kb", stats.texturememory / 1024), 10, love.graphics.getHeight() - 80);
    love.graphics.print(string.format("Images: %d", stats.images), 10, love.graphics.getHeight() - 60);
    love.graphics.print(string.format("Canvases: %d", stats.canvases), 10, love.graphics.getHeight() - 40);
    love.graphics.print(string.format("Fonts: %d", stats.fonts), 10, love.graphics.getHeight() - 20);
end

-- ------------------------------------------------
-- Callbacks
-- ------------------------------------------------

function love.load()
    print("===================")
    print(string.format("Title: '%s'", getTitle()));
    print(string.format("Version: %s", getVersion()));
    print(string.format("LOVE Version: %d.%d.%d (%s)", love.getVersion()));
    print(string.format("Resolution: %dx%d", love.graphics.getDimensions()));

    print("\n---- RENDERER  ---- ");
    local name, version, vendor, device = love.graphics.getRendererInfo()
    print(string.format("Name: %s \nVersion: %s \nVendor: %s \nDevice: %s", name, version, vendor, device));

    print("===================")
    print(os.date('%c', os.time()));
    print("===================")

    local screens = {
        main = require('src.screens.MainScreen');
    };

    ScreenManager.init(screens, 'main');
end

function love.draw()
    ScreenManager.draw();

    if showDebug then
        drawStats();
    end
end

function love.update(dt)
    ScreenManager.update(dt);
end

function love.quit(q)
    ScreenManager.quit(q);
end

function love.keypressed(key)
    if key == 'f1' then
        showDebug = not showDebug;
    end

    ScreenManager.keypressed(key);
end
