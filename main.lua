function love.load()
    OS = love.system.getOS();
    local load = setmetatable({
        Windows = function(self)
            love.window.setTitle("Castle Crashers Clone");

            WINDOW = {};
            WINDOW.width, WINDOW.height = love.window.getMode();

            DESKTOP = {};
            DESKTOP.width, DESKTOP.height = love.window.getDesktopDimensions();
            print(DESKTOP.width, DESKTOP.height);
            function DESKTOP.calculateHeightFromWidth(width)
                return width / (DESKTOP.width / DESKTOP.height);
            end;

            love.window.setMode(WINDOW.width, WINDOW.height, {
                resizable = true,
                minwidth = 880,
                minheight = DESKTOP.calculateHeightFromWidth(880)
            });
            love.resize(WINDOW.width, WINDOW.height);
        end,
        Android = "Windows"
    }, {
        __call = function(self, os)
            local func = self[os];
            if not func then
                return error("unsupported os: " .. os);
            end;
            if type(func) == "string" then
                return self(func);
            end;
            return func(self);
        end;
    });
    load(OS);
end;
function love.draw()
    print(WINDOW.width, WINDOW.height);
    love.graphics.print("Hello, World!", WINDOW.width / 2, WINDOW.height / 2);
end;

function love.resize(width, height)
    height = DESKTOP.calculateHeightFromWidth(width);
    local flags = select(3, love.window.getMode());
    love.window.setMode(width, height, flags);
    WINDOW.width = width;
    WINDOW.height = height;
end;