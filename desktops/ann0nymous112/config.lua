local path = "desktops/ann0nymous112"

return {
    path = path,
    name = "ann0nymous112",
    pfp = love.graphics.newImage(path.."/pfp.png"),
    theme = "dark",
    background = {
        t = "image", img = love.graphics.newImage(path.."/background.png")
    },
    avalablePrograms = {"remotedesktop","inbox","bank","antivirus"},
    desktop = {
        {
            pos = {1,1},
            name = "victimfiles",
            type = "folder",
            {
                name = "user1",
                type = "text",
                content = {
                    {"victim report:"},
                    {"name: user1","left"},
                    {"action: bank drained","left"},
                    {"comment: the test subject has drained his bank account successfully.","left"}
                }
            },
            {
                name = "floral16",
                type = "text",
                content = {
                    {"victim report:"},
                    {"name: floral16","left"},
                    {"action: pc destroyed","left"},
                    {"comment: the test subject has made their pc disfunctional.","left"}
                }
            },
            {
                name = "loveuser",
                type = "text",
                content = {
                    {"victim report:"},
                    {"name: loveuser","left"},
                    {"status: in my control","left"}
                }
            }
        },
        {
            pos = {2,1},
            name = "victimfiles2",
            type = "folder",
            {
                name = "cursedgoomba1",
                type = "text",
                content = {
                    {"victim report:"},
                    {"name: cursedgoomba1","left"},
                    {"action: none yet","left"},
                    {"comment: waiting for test subject to finish with floral16.","left"}
                }
            }
        },
        {
            pos = {1,2},
            name = "utils",
            type = "folder",
            {
                name = "zipcrash",
                type = "folder",
                {
                    name = "zipcrash plans",
                    type = "text",
                    content = {
                        {"zipcrash plans:"},
                        {"- make sure there is no way to fix it (done)\n- attach to factoryreset? (wip)","left"}
                    }
                }
            },
            {
                name = "factoryreset",
                type = "text",
                icon = "blank"
            },
        },
        {
            pos = {1,3},
            name = "leaks",
            type = "folder",
            {
                name = "inbox.com",
                type = "folder",
                {
                    name = "user1 (deleted)",
                    type = "text",
                    content = {
                        {"inbox.com data report: user1@inbox.com"},
                        {"pc name: user1","left"},
                        {"password: iloveboss22","left"},
                        {"bank accounts: (2 found)","left"},
                        {"- user1: £9640","left"},
                        {"- savings: £23","left"}
                    }
                },
                {
                    name = "floral16 (deleted)",
                    type = "text",
                    content = {
                        {"inbox.com data report: daisy_f@inbox.com"},
                        {"pc name: floral16","left"},
                        {"password: daisy987","left"},
                        {"bank accounts: (0 found)","left"}
                    }
                },
                {
                    name = "loveuser",
                    type = "text",
                    content = {
                        {"inbox.com data report: loveuser@inbox.com"},
                        {"pc name: loveuser","left"},
                        {"password: lovewhale11","left"},
                        {"bank accounts: (0 found)","left"}
                    }
                }
            },
            {
                name = "bank",
                type = "folder",
            },
            {
                name = "antivirus",
                type = "folder",
            }
        },
        {
            pos = {1,5},
            name = "inbox",
            type = "shortcut",
            target = "b:/programs/inbox"
        },
        {
            pos = {1,6},
            name = "bank",
            type = "shortcut",
            target = "b:/programs/bank"
        },
        {
            pos = {1,7},
            name = "antivirus",
            type = "shortcut",
            target = "b:/programs/antivirus"
        },
        {
            pos = {13,1},
            name = "goal",
            type = "text",
            content = "where did you go? i can't see you on my radar, must have been the virus... just don't touch anything.\n\n- ann0nymous112"
        },
        {
            pos = {13,2},
            name = "you'rehere",
            type = "text",
            content = "oh i see, your on my pc... you think you have some kind of control? well you don't.\n\ni'm going to make sure you never leave now. enjoy trying to leave!!!\n\n- ann0nymous112",
            hidden = true
        }
    },
    bin = {},
    emails = {
        {
            email = "user1@inbox.com",
            password = "iloveboss22",
            deleted = true
        },
        {
            email = "daisy_f@inbox.com",
            password = "daisy987",
            deleted = true
        },
        {
            email = "loveuser@inbox.com",
            password = "lovewhale11",
            emails = {
                {
                    from = "unknown",
                    to = "loveuser@inbox.com",
                    subject = "one last hope",
                    content = "you don't know who i am, but you need to trust me when i say i brought you here, ann0nymous112 has been ruining peoples lives for too long, i need you to help me stop him. all you need to do is find the factory reset button. the emails i just should be of help.\n\ngood luck\n\n- unknown",
                    onOpen = function(desktop,window)
                        for _,email in pairs(window.emails) do
                            email.hidden = false
                        end
                    end
                },
                {
                    from = "unknown",
                    to = "loveuser@inbox.com",
                    subject = "re: antivirus issue",
                    content = "fyi",
                    hidden = true,
                    reference = {
                        from = "ann0n7@inbox.com",
                        to = "support.antivirus@inbox.com",
                        subject = "antivirus issue",
                        content = "i have a problem with my antivirus, i can't log in.\n\nusername is ann0n112, fix asap."
                    }
                }
            }
        }
    },
    openByDefault = "b:/programs/howtoplay"
}