Desktop = Class("Desktop")

function Desktop:initialize()
    self.w, self.h = Env.width, Env.height
    self.background = {t="color", color={0.4,0.7,1}}

    self.startMenu = {
        w = 200, h = 300,
        open = false,
        buttons = {}
    }
    self.taskbar = {
        h = 20,
        buttons = {
            DesktopButton:new(self, false)
        }
    }

    self.focus = false
    self.windows = {}

    self.filesystem = {
        {
            name = "desktop",
            icon = "desktop",
            type = "folder",
            {
                name = "text",
                type = "text",
                content = "hello, world!",
            },
            {
                name = "junk",
                type = "folder",
                {
                    name = "1",
                    type = "text",
                    content = "i really like dogs"
                },
                {
                    name = "2",
                    type = "text",
                    content = "i really like cats"
                },
                {
                    name = "homework :)",
                    type = "folder",
                    {
                        name = "math",
                        type = "text",
                        content = "1+1=2"
                    },
                    {
                        name = "english",
                        type = "text",
                        content = "i like dogs"
                    }
                }
            }

        },
        {
            name = "bin",
            icon = "bin",
            type = "folder",
            {
                name = "not my password",
                type = "text",
                content = "password: britdan1234"
            }
        },
        {
            name = "programs",
            icon = "programs",
            type = "folder",
            {
                name = "file manager",
                type = "program",
                icon = "filemanager",
                program = "filemanager",
                window = WindowFileManager
            },
            {
                name = "text viewer",
                type = "program",
                icon = "textviewer",
                program = "textviewer",
                window = WindowTextViewer
            }
        },
        {
            name = "debug",
            icon = "blank",
            type = "folder",
            hidden = true,
            {
                name = "debug",
                type = "text",
                content = "this is a debug file"
            }
        }
    }

    self.theme = "dark"
    self.themes = {
        dark = {
            taskbar = {
                background = {0.2,0.2,0.2,0.9},
                text = {1,1,1},
            },
            window = {
                background = {0.1,0.1,0.1},
                subbackground = {0.2,0.2,0.2},
                navbar = {
                    background = {0.3,0.3,0.3},
                    text = {1,1,1}
                }
            }
        }
    }
end

function Desktop:getColor(name,subname)
    if subname then
        return self.themes[self.theme]["taskbar"][name][subname]
    end
    return self.themes[self.theme]["taskbar"][name]
end

function Desktop:update(dt)
    for _, window in pairs(self.windows) do
        window:update(dt)
    end
end

function Desktop:draw()
    -- Draw background
    if self.background.t == "color" then
        love.graphics.setColor(self.background.color)
    end
    love.graphics.rectangle("fill", 0, 0, self.w, self.h)

    -- Draw desktop icons
    local files = self:getFile("b:/desktop")
    if files then
        local y = 8
        local hover = self:hoveringFile()
        for i, file in ipairs(files) do
            local file = file
            local isShortcut = false
            if file.type == "shortcut" then
                file = self:getFileFromShortcut(file)
                isShortcut = true
            end
            if file and file.hidden ~= true then
                love.graphics.setColor(0,0,0)
                love.graphics.printf(file.name, 4, y+34, 40, "center")
                love.graphics.setColor({1,1,1,0})
                if hover == i then
                    love.graphics.setColor({1,1,1,0.5})
                end
                love.graphics.rectangle("fill", 8, y, 32, 32)
                love.graphics.setColor({1,1,1})
                if file.icon then
                    love.graphics.draw(IconsImg, IconsQuads[file.icon], 8, y, 0, 2, 2)
                else
                    love.graphics.draw(IconsImg, IconsQuads[file.type], 8, y, 0, 2, 2)
                end
                if isShortcut then
                    love.graphics.draw(IconsImg, IconsQuads["shortcut"], 8, y, 0, 2, 2)
                end
                y = y + 44
            end
        end
    end

    -- Draw windows below task bar and icons
    for i = #self.windows, 1, -1 do
        local window = self.windows[i]
        window:draw()
    end

    -- Draw start menu
    if self.startMenu.open then
        love.graphics.setColor(self:getColor("background"))
        love.graphics.rectangle("fill", 0, self.h-self.taskbar.h-self.startMenu.h, self.startMenu.w, self.startMenu.h)
        love.graphics.setColor(self:getColor("text"))
        love.graphics.print("no idea what i'll use this for", 4, self.h-self.taskbar.h-self.startMenu.h+4)
    end

    -- Draw task bar
    love.graphics.setColor(self:getColor("background"))
    love.graphics.rectangle("fill", 0, self.h-self.taskbar.h, self.w, self.taskbar.h)

    -- Draw task bar buttons
    for i, button in pairs(self.taskbar.buttons) do
        button:draw(i)
    end

    -- Draw time
    love.graphics.setColor(self:getColor("text"))
    love.graphics.printf(os.date("%H:%M"), self.w-50, self.h-self.taskbar.h+2, 50, "center")
    love.graphics.printf(os.date("%x"), self.w-50, self.h-self.taskbar.h+11, 50, "center")
end

function Desktop:mousepressed(mx, my, b)
    self.startMenu.open = false
    if my < self.h-self.taskbar.h then
        self.dontOverwriteFocus = false
        self.focus = false
        for i, window in pairs(self.windows) do
            if window:mousepressed(mx, my, b) then
                if not self.dontOverwriteFocus then
                    self:windowBringToFront(window)
                    self.focus = window
                end
                return
            end
        end
        local hover = self:hoveringFile()
        if hover then
            local file = self:getFile("b:/desktop")[hover]
            if file.type == "shortcut" then
                file = self:getFileFromShortcut(file)
            end
            self:openFile(file)
        end
    else
        for i, button in pairs(self.taskbar.buttons) do
            button:mousepressed(mx, my, i, b)
        end
    end
end
function Desktop:mousereleased(mx, my, b)
    for i, button in pairs(self.taskbar.buttons) do
        button:mousereleased(mx, my, i, b)
    end
    for _, window in pairs(self.windows) do
        window:mousereleased(mx, my, b)
    end
end

function Desktop:textinput(text)
    if self.focus then
        self.focus:textinput(text)
    end
end

function Desktop:keypressed(key, scancode, isrepeat)
    if self.focus then
        self.focus:keypressed(key, scancode, isrepeat)
    end
end

--

function Desktop:getFile(path)
    path = string.gsub(path, "^b:/", "")
    path = Split(path, "/")
    local file = self.filesystem
    for i = 1, #path do
        file = TableContainsWithin(file, path[i], "name")
        if not file then
            return false
        end
    end
    return file
end

function Desktop:getFileFromShortcut(file)
    local target = self:getFile(file.target)
    if target then
        return target
    end
    return false
end

function Desktop:hoveringFile()
    local mx, my = love.mouse.getX()/Env.scale, love.mouse.getY()/Env.scale
    local files = self:getFile("b:/desktop")
    if files then
        local y = 8
        for i, file in ipairs(files) do
            if file then
                if AABB(mx, my, 1, 1, 8, y, 32, 32) then
                    return i
                end
                y = y + 44
            end
        end
    end
    return false
end

function Desktop:openFile(file,window)
    -- Open program
    if file.type == "program" then
        local windowP = self:windowExists(file.program)
        if windowP then
            self:windowBringToFront(windowP)
            self.focus = windowP
            self.minimized = false
            return
        end
        table.insert(self.windows, file.window:new(self,nil,nil,400,300))
        table.insert(self.taskbar.buttons, DesktopButton:new(self, self.windows[#self.windows]))
        self.focus = self.windows[#self.windows]
        self:windowBringToFront(self.windows[#self.windows])
        return
    end

    -- Open folder
    if file.type == "folder" then
        if window and window.program == "filemanager" then
            window.elements.path.text = window.elements.path.text..file.name.."/"
            return
        end
        local windowP = self:windowExists("filemanager")
        if windowP then
            windowP.elements.path.text = "b:/desktop/"..file.name.."/"
            self:windowBringToFront(windowP)
            self.focus = windowP
            self.minimized = false
            return
        end
        table.insert(self.windows, WindowFileManager:new(self,nil,nil,400,300,"b:/desktop/"..file.name.."/"))
        table.insert(self.taskbar.buttons, DesktopButton:new(self, self.windows[#self.windows]))
        self.focus = self.windows[#self.windows]
        self:windowBringToFront(self.windows[#self.windows])
        return
    end

    -- Open text
    if file.type == "text" then
        local windowP = self:windowExists("textviewer")
        if windowP then
            windowP.content = file.content
            windowP.filename = file.name..".text"
            self:windowBringToFront(windowP)
            self.focus = windowP
            self.minimized = false
            return
        end
        table.insert(self.windows, WindowTextViewer:new(self,nil,nil,250,200,file.content,file.name..".text"))
        table.insert(self.taskbar.buttons, DesktopButton:new(self, self.windows[#self.windows]))
        self.focus = self.windows[#self.windows]
        self:windowBringToFront(self.windows[#self.windows])
        return
    end
end

--

function Desktop:windowExists(program)
    for _, window in pairs(self.windows) do
        if window.program == program then
            return window
        end
    end
    return false
end

function Desktop:windowClose(targetWindow)
    for i, window in pairs(self.windows) do
        if window == targetWindow then
            table.remove(self.windows, i)
            for i, button in pairs(self.taskbar.buttons) do
                if button.window == targetWindow then
                    table.remove(self.taskbar.buttons, i)
                    return
                end
            end
            return
        end
    end
end

function Desktop:windowBringToFront(targetWindow)
    local newWindows = {}
    table.insert(newWindows, targetWindow)
    for i, window in pairs(self.windows) do
        if window ~= targetWindow then
            table.insert(newWindows, window)
        end
    end
    self.windows = newWindows
end