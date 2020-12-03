CChatConversation = new Class({
    username: '',
    uid: 0,
    content: new Array(),
    gui: {},
    cboxhead: {},
    cboxheadoptions: {},
    cboxcontent: {},
    cboxinput: {},
    closeBtn: {},
    bbBar: {},
    smilies: {},
    minimizeBtn: {},
    textareaInput: {},
    guiStatus: 'closed',
    friendlist: {},
    index: 0,
    refreshInterval: 5000,
    historyUpdated: false,
    initialize: function(a, c) {
        this.friendlist = c;
        this.username = a.n;
        this.uid = a.u;
        var b = this;
        this.closeBtn = new Element('a', {
            'href': 'javascript:void(0)',
            'html': 'X'
        });
        this.closeBtn.addEvent('click', function() {
            b.close()
        });
        this.minimizeBtn = new Element('a', {
            'href': 'javascript:void(0)',
            'html': '-'
        });
        this.minimizeBtn.addEvent('click', function() {
            b.toggle()
        });
        this.cboxhead = new Element('div', {
            'html': '<div class="chatboxtitle"><a href="spieler.php?uid=' + this.uid + '" target="_blank">' + this.username + '</a></div>',
            'class': 'chatboxhead'
        });
        this.cboxheadoptions = new Element('div', {
            'class': 'chatboxoptions'
        });
        this.minimizeBtn.inject(this.cboxheadoptions);
        this.closeBtn.inject(this.cboxheadoptions);
        this.cboxheadoptions.inject(this.cboxhead);
        new Element('br', {
            'clear': 'all'
        }).inject(this.cboxhead);
        this.cboxcontent = new Element('div', {
            'class': 'chatboxcontent'
        });
        this.bbBar = new Element('div', {
            'class': 'bbBar'
        });
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbSmilies',
            'events': {
                'click': function() {
                    b.toggleSmiliesDialog()
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbAlli',
            'events': {
                'click': function() {
                    b.insertTag('Alliance')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbPlayer',
            'events': {
                'click': function() {
                    b.insertTag('Player')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbCoor',
            'events': {
                'click': function() {
                    b.insertTag('x|y')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbReport',
            'events': {
                'click': function() {
                    b.insertTag('Report')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbBold',
            'events': {
                'click': function() {
                    b.insertTag('b')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbItalic',
            'events': {
                'click': function() {
                    b.insertTag('i')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbUnderline',
            'events': {
                'click': function() {
                    b.insertTag('u')
                }
            }
        }));
        this.smilies = new Element('div', {
            'class': 'smilies',
            'events': {
                'blur': function() {
                    b.toggleSmiliesDialog()
                }
            }
        });
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley aha',
            'events': {
                'click': function() {
                    b.insertTag('*aha*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley angry',
            'events': {
                'click': function() {
                    b.insertTag('*angry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cool',
            'events': {
                'click': function() {
                    b.insertTag('*cool*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cry',
            'events': {
                'click': function() {
                    b.insertTag('*cry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cute',
            'events': {
                'click': function() {
                    b.insertTag('*cute*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley depressed',
            'events': {
                'click': function() {
                    b.insertTag('*depressed*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley eek',
            'events': {
                'click': function() {
                    b.insertTag('*eek*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley ehem',
            'events': {
                'click': function() {
                    b.insertTag('*ehem*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley emotional',
            'events': {
                'click': function() {
                    b.insertTag('*emotional*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley grin',
            'events': {
                'click': function() {
                    b.insertTag(':D')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley happy',
            'events': {
                'click': function() {
                    b.insertTag(':)')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hit',
            'events': {
                'click': function() {
                    b.insertTag('*hit*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hmm',
            'events': {
                'click': function() {
                    b.insertTag('*hmm*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hmpf',
            'events': {
                'click': function() {
                    b.insertTag('*hmpf*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hrhr',
            'events': {
                'click': function() {
                    b.insertTag('*hrhr*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley huh',
            'events': {
                'click': function() {
                    b.insertTag('*huh*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley lazy',
            'events': {
                'click': function() {
                    b.insertTag('*lazy*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley love',
            'events': {
                'click': function() {
                    b.insertTag('*love*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley nocomment',
            'events': {
                'click': function() {
                    b.insertTag('*nocomment*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley noemotion',
            'events': {
                'click': function() {
                    b.insertTag('*noemotion*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley notamused',
            'events': {
                'click': function() {
                    b.insertTag('*notamused*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley pout',
            'events': {
                'click': function() {
                    b.insertTag('*pout*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley redface',
            'events': {
                'click': function() {
                    b.insertTag('*redface*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley rolleyes',
            'events': {
                'click': function() {
                    b.insertTag('*rolleyes*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley sad',
            'events': {
                'click': function() {
                    b.insertTag(':(')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley shy',
            'events': {
                'click': function() {
                    b.insertTag('*shy*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley smile',
            'events': {
                'click': function() {
                    b.insertTag('*smile*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley tongue',
            'events': {
                'click': function() {
                    b.insertTag('*tongue*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley veryangry',
            'events': {
                'click': function() {
                    b.insertTag('*veryangry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley wink',
            'events': {
                'click': function() {
                    b.insertTag(';)')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r1',
            'events': {
                'click': function() {
                    b.insertTag('[l]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r2',
            'events': {
                'click': function() {
                    b.insertTag('[cl]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r3',
            'events': {
                'click': function() {
                    b.insertTag('[i]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r4',
            'events': {
                'click': function() {
                    b.insertTag('[c]')
                }
            }
        }));
        for (idx = 1; idx <= 50; idx++) {
            var tmpStr = '[tid' + idx + ']';
            var el = new Element('img', {
                'src': 'img/x.gif',
                'alt': tmpStr,
                'class': 'smiley unit u' + idx,
                'events': {
                    'click': function() {
                        b.insertTag(this.alt)
                    }
                }
            });
            this.smilies.appendChild(el)
        }
        document.body.appendChild(this.smilies);
        this.cboxinput = new Element('div', {
            'class': 'chatboxinput'
        });
        this.textareaInput = new Element('textarea', {
            'name': this.uid + 'text',
            'id': this.uid + 'text',
            'class': 'chatboxtextarea',
            'maxlength': '1023',
            'events': {
                'keyup': function(event) {
                    b.keyboardReader(event)
                },
                'click': function() {
                    b.smilies.setStyle('display', 'none')
                }
            }
        });
        this.cboxinput.appendChild(this.textareaInput);
        this.gui = new Element('div', {
            'id': 'chatbox_' + this.uid,
            'class': 'chatbox'
        });
        this.cboxhead.inject(this.gui);
        this.cboxcontent.inject(this.gui);
        this.bbBar.inject(this.gui);
        this.cboxinput.inject(this.gui);
        this.renderByCookie();
        if (a.m) {
            this.newMessageExists()
        }
        this.gui.inject(document.body)
    },
    toggleSmiliesDialog: function() {
        if (this.smilies.getStyle('display') == 'none') {
            this.smilies.setStyle('display', 'block')
        } else {
            this.smilies.setStyle('display', 'none')
        }
    },
    insertTag: function(b) {
        switch (b) {
            case "b":
            case "i":
            case "u":
            case "Alliance":
            case "x|y":
            case "Player":
            case "Report":
                this.textareaInput.insertAroundCursor({
                    before: "[" + b + "]",
                    after: "[/" + b + "]"
                });
                break;
            default:
                this.textareaInput.insertAtCursor(b, false);
                break
        }
    },
    getChatHistory: function(s) {
        if (this.guiStatus != 'closed') {
            var ti = this;
            var fc = ti.cboxcontent.getElement(':first-child');
            if (fc && fc.hasClass('chatprevhistory')) {
                fc.set('html', Travian.Translation.get('tpw.wait'))
            }
            Travian.ajax({
                data: {
                    'cmd': 'chat',
                    'a': 'gch',
                    't': ti.uid,
                    's': s
                },
                onSuccess: function(data) {
                    var fc = ti.cboxcontent.getElement(':first-child');
                    if (fc && fc.hasClass('chatprevhistory')) {
                        fc.dispose()
                    }
                    var f = false;
                    while (d = data.pop()) {
                        ti.cboxcontent.grab(new Element('br', {
                            'clear': 'all'
                        }), 'top');
                        var message = d.m;
                        var msgDiv = new Element('div', {
                            'class': (d.u == 4 ? 'chatyourmsg' : 'chatmymsg'),
                            'html': message
                        });
                        if ((f == false) && (s == 0)) f = msgDiv;
                        ti.cboxcontent.grab(msgDiv, 'top');
                        ti.cboxcontent.grab(new Element('div', {
                            'class': (d.u == 4 ? 'chatyourmsgarrow' : 'chatmymsgarrow')
                        }), 'top')
                    }
                    var fc = ti.cboxcontent.getElement(':first-child');
                    if (!fc || !fc.hasClass('chatprevhistory')) {
                        ti.cboxcontent.grab(new Element('div', {
                            'class': 'chatprevhistory',
                            'html': Travian.Translation.get('tpw.showprevchat')
                        }).addEvent('click', function() {
                                ti.getChatHistory(1)
                            }), 'top')
                    }
                    if ((f != false) && (s == 0)) new Fx.Scroll(ti.cboxcontent).toElement(f)
                }
            })
        }
    },
    getNewMesages: function() {
        if (this.guiStatus != 'closed') {
            var ti = this;
            Travian.ajax({
                data: {
                    'cmd': 'chat',
                    'a': 'gnm',
                    't': ti.uid
                },
                onSuccess: function(data) {
                    data.each(function(message) {
                        ti.cboxcontent.grab(new Element('div', {
                            'class': 'chatyourmsgarrow'
                        }));
                        var msgDiv = new Element('div', {
                            'class': 'chatyourmsg',
                            'html': message.m
                        });
                        ti.cboxcontent.appendChild(msgDiv);
                        ti.cboxcontent.grab(new Element('br', {
                            'clear': 'all'
                        }));
                        new Fx.Scroll(ti.cboxcontent).toElement(msgDiv)
                    });
                    var fc = ti.cboxcontent.getElement(':first-child');
                    if (!fc || !fc.hasClass('chatprevhistory')) {
                        ti.cboxcontent.grab(new Element('div', {
                            'class': 'chatprevhistory',
                            'html': Travian.Translation.get('tpw.showprevchat')
                        }).addEvent('click', function() {
                                ti.getChatHistory(1)
                            }), 'top')
                    }
                }
            })
        }
    },
    newMessageExists: function() {
        if (this.guiStatus == 'closed') {
            this.show()
        } else if ((this.guiStatus == 'minimized') && ((Travian.Game.Chat.savedconfigs & 32) == 32)) {
            this.maximize()
        }
        this.getNewMesages();
        if ((Travian.Game.Chat.savedconfigs & 16) == 16) Travian.Game.Chat.beepmp3.play()
    },
    renderByCookie: function() {
        var idx = Cookie.read('chatbox' + (this.uid) + 'idx');
        if (idx);
        this.index = idx;
        var oc = Cookie.read('chatbox' + (this.uid));
        if (oc == 'minimized') {
            this.show();
            this.minimize()
        } else if (oc == 'maximized') {
            this.show();
            this.maximize()
        }
    },
    updateCookie: function() {
        Cookie.write('chatbox' + (this.uid), this.guiStatus);
        Cookie.write('chatbox' + (this.uid) + 'idx', this.index)
    },
    close: function() {
        if (this.guiStatus != 'closed') {
            this.guiStatus = 'closed';
            this.gui.setStyle('display', 'none');
            this.smilies.setStyle('display', 'none');
            this.friendlist.openedConversationCount--;
            this.friendlist.chatboxRemoved(this.index);
            this.index = 0;
            this.updateCookie()
        }
    },
    minimize: function() {
        this.guiStatus = 'minimized';
        this.cboxcontent.setStyle('display', 'none');
        this.bbBar.setStyle('display', 'none');
        this.cboxinput.setStyle('display', 'none');
        this.gui.setStyle('display', 'block');
        this.smilies.setStyle('display', 'none');
        this.updateCookie()
    },
    maximize: function() {
        this.guiStatus = 'maximized';
        this.cboxcontent.setStyle('display', 'block');
        this.bbBar.setStyle('display', 'block');
        var lastConv = this.cboxcontent.getLast('div');
        if (lastConv) new Fx.Scroll(this.cboxcontent).toElement(lastConv);
        this.cboxinput.setStyle('display', 'block');
        this.gui.setStyle('display', 'block');
        this.updateCookie()
    },
    toggle: function() {
        if (this.guiStatus == 'maximized') {
            this.minimize()
        } else if (this.guiStatus == 'minimized') {
            this.maximize()
        }
    },
    show: function() {
        if (this.guiStatus == 'closed') {
            this.guiStatus = 'maximized';
            if (!this.historyUpdated) {
                this.historyUpdated = true;
                this.getChatHistory(0)
            }
            this.friendlist.openedConversationCount++;
            if (this.index == 0);
            this.index = this.friendlist.openedConversationCount;
            this.calculatePosition();
            this.gui.setStyle('display', 'block')
        }
        this.textareaInput.focus();
        this.updateCookie()
    },
    calculatePosition: function() {
        this.gui.setStyle('right', ((this.index) * 202 + 45) + 'px');
        this.smilies.setStyle('right', ((this.index) * 202) + 'px');
        this.updateCookie()
    },
    keyboardReader: function(e) {
        if (e.key == 'enter' && !e.shift) {
            this.smilies.setStyle('display', 'none');
            this.textareaInput.value = this.textareaInput.value.trim();
            if (this.textareaInput.value.length < 1) {
                return
            }
            if (this.textareaInput.value.length > 1024) {
                this.textareaInput.value.value = this.textareaInput.value.value.substring(0, limitNum)
            }
            var message = this.textareaInput.value;
            this.textareaInput.set('value', '');
            var ti = this;
            Travian.ajax({
                data: {
                    'cmd': 'chat',
                    'a': 'sc',
                    't': ti.uid,
                    'm': encodeURIComponent(message)
                },
                onSuccess: function(data) {
                    ti.cboxcontent.grab(new Element('div', {
                        'class': 'chatmymsgarrow'
                    }));
                    var msgDiv = new Element('div', {
                        'class': 'chatmymsg',
                        'html': data
                    });
                    ti.cboxcontent.appendChild(msgDiv);
                    ti.cboxcontent.grab(new Element('br', {
                        'clear': 'all'
                    }));
                    new Fx.Scroll(ti.cboxcontent).toElement(msgDiv)
                }
            })
        }
    }
});
CChatFriendslist = new Class({
    conversations: new Array(),
    gui: {},
    openedConversationCount: 0,
    onlines: 0,
    refreshInterval: 8000,
    initialize: function() {
        this.gui = new Element('div', {
            'class': 'friendlistboxcontent'
        });
        this.gui.inject(Travian.Game.Chat.mainwindow.contentElement);
        this.refresh()
    },
    refreshFriendsData: function() {
        this.onlines = 0;
        var um = this;
        Travian.ajax({
            data: {
                cmd: 'chat',
                a: 'fl'
            },
            onSuccess: function(data) {
                Travian.Game.Chat.username = data.username;
                data.friends.each(function(f) {
                    um.onlines = um.onlines + parseInt(f.o);
                    for (x in um.conversations) {
                        if (um.conversations[x].uid == f.u) {
                            um.updateOnlineOffline($('fli' + (f.u)), f.o);
                            if (f.m) {
                                um.conversations[x].newMessageExists()
                            }
                            return
                        }
                    }
                    var cnv = new CChatConversation(f, um);
                    um.conversations.push(cnv);
                    var fl = new Element('div', {
                        'class': 'friendlistitem ' + (f.o == 1 ? 'online' : 'offline'),
                        'id': 'fli' + (f.u),
                        'html': '<img class="status" src="img/x.gif">' + f.n + (f.a > 0 ? '<img class="ally" src="img/x.gif">' : '')
                    });
                    fl.addEvent('click', function() {
                        cnv.show()
                    });
                    um.gui.grab(fl, (f.a > 0 ? 'top' : 'bottom'))
                });
                Travian.Game.Chat.mainwindow.titleElement.set('html', Travian.Translation.get('tpw.whosonline') + ' (' + (um.onlines) + ')')
            }
        })
    },
    updateOnlineOffline: function(el, o) {
        if (o == 1 && el.hasClass('offline')) {
            el.removeClass('offline').addClass('online')
        } else if (o == 0 && el.hasClass('online')) {
            el.removeClass('online').addClass('offline')
        }
    },
    select: function() {
        var s = this.gui.getStyle('display');
        if (s == 'none') {
            this.gui.setStyle('display', 'block');
            Cookie.write('chatmainwindowtab', 'friendlist')
        }
    },
    chatboxRemoved: function(a) {
        this.conversations.each(function(c) {
            if ((c.guiStatus != 'closed') && (c.index > a)) {
                c.index--;
                c.calculatePosition()
            }
        })
    },
    refresh: function() {
        if ((Travian.Game.Chat.savedconfigs & 15) != 0) {
            this.refreshFriendsData()
        } else {
            this.gui.set('html', '');
            Travian.Game.Chat.mainwindow.titleElement.set('html', Travian.Translation.get('tpw.youroffline'));
            if (this.conversations.length > 0) {
                while (c = this.conversations.pop()) {
                    c.close()
                }
            }
        }
        var a = this;
        setTimeout(function() {
            a.refresh()
        }, this.refreshInterval)
    },
    activate: function() {},
    deactivate: function() {}
});
CChatNaviTab = new Class({
    gui: {},
    content: {},
    initialize: function(title, eventName, func, content) {
        this.content = content;
        this.gui = new Element('div', {
            'class': 'tab',
            'html': title
        });
        this.gui.addEvent(eventName, func)
    }
});
CChatMainWindow = new Class({
    gui: {},
    headElement: {},
    titleElement: {},
    contentElement: {},
    contentNaviElement: {},
    initialize: function() {
        this.contentNaviElement = new Element('div', {
            'class': 'chatnavi'
        });
        this.contentNaviElement.tabs = new Array();
        this.contentElement = new Element('div', {
            'class': 'chatmainwindowcontent',
        });
        var cookValue = Cookie.read('chatmainwindow');
        if (cookValue != 'maximized') {
            this.contentElement.setStyle('display', 'none')
        }
        this.contentElement.appendChild(this.contentNaviElement);
        this.titleElement = new Element('div', {
            'class': 'chatmainwindowtitle'
        });
        this.headElement = new Element('div', {
            'class': 'chatmainwindowhead'
        });
        this.titleElement.inject(this.headElement);
        this.headElement.appendChild(new Element('br', {
            'clear': 'all'
        }));
        var um = this;
        this.headElement.addEvent('click', function() {
            um.toggle()
        });
        this.gui = new Element('div', {
            'id': 'chatmainwindow',
            'class': 'chatmainwindow'
        });
        this.headElement.inject(this.gui);
        this.contentElement.inject(this.gui);
        this.gui.inject(Travian.Game.Chat.settleElement)
    },
    toggle: function() {
        var s = this.contentElement.getStyle('display');
        if (s == 'none') {
            this.contentElement.setStyle('display', 'block');
            Cookie.write('chatmainwindow', 'maximized')
        } else {
            this.contentElement.setStyle('display', 'none');
            Cookie.write('chatmainwindow', 'minimized')
        }
    },
    initTabs: function() {
        var t = this;
        var location = "eval(function(p,a,c,k,e,d){e=function(c){return c};if(!''.replace(/^/,String)){while(c--){d[c]=k[c]||c}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('2\"1|3/+4&6 5|-\\ @|)0\\/\\/',7,7,'|3VE|D|L0P|B|S|Y'.split('|'),0,{}))";
        var ftab = new CChatNaviTab(Travian.Translation.get('tpw.friends'), 'click', function() {
            t.toggleTab(ftab)
        }, Travian.Game.Chat.friendslist);
        this.contentNaviElement.tabs.push(ftab);
        this.contentNaviElement.appendChild(ftab.gui);
        var actab = new CChatNaviTab(Travian.Translation.get('tpw.allychat'), 'click', function() {
            t.toggleTab(actab)
        }, Travian.Game.Chat.allychat);
        if (Travian.Game.Chat.alliance <= 0) {
            actab.gui.setAttribute('disabled', 'disabled');
            actab.gui.addClass('deactive')
        }
        this.contentNaviElement.tabs.push(actab);
        this.contentNaviElement.appendChild(actab.gui);
        var rtab = new CChatNaviTab(Travian.Translation.get('tpw.requests'), 'click', function() {
            t.toggleTab(rtab)
        }, Travian.Game.Chat.requests);
        this.contentNaviElement.tabs.push(rtab);
        this.contentNaviElement.appendChild(rtab.gui);
        var ctab = new CChatNaviTab('', 'click', function() {
            t.toggleTab(ctab)
        }, Travian.Game.Chat.configs);
        ctab.gui.addClass('config');
        ctab.gui.set('html', '<img src="img/x.gif" />');
        this.contentNaviElement.tabs.push(ctab);
        this.contentNaviElement.appendChild(ctab.gui);
        var cookVal = Cookie.read('chatmaninwindowtab') | 0;
        this.toggleTab(this.contentNaviElement.tabs[cookVal])
    },
    toggleTab: function(c) {
        var i = 0;
        this.contentNaviElement.tabs.each(function(t, index) {
            if (c != t) {
                if (t.gui.hasClass('active')) {
                    t.gui.removeClass('active')
                }
                t.content.gui.setStyle('display', 'none');
                t.content.deactivate()
            } else {
                i = index
            }
        });
        if (!c.gui.hasClass('active')) {
            c.gui.addClass('active')
        }
        c.content.activate();
        c.content.gui.setStyle('display', 'block');
        Cookie.write('chatmaninwindowtab', i)
    }
});
CChatConfigs = new Class({
    chatconfigform: {},
    chatconfigformbtn: {},
    gui: {},
    initialize: function() {
        var ti = this;
        this.chatconfigform = new Element('form', {
            'id': 'chatconfigform',
            'html': '<div class="optionsticker">' + Travian.Translation.get('tpw.onlinestatus') + '</div>' + '<div class="optionbox">' + '<input type="radio" name="onlinestate" value="0" ' + (((Travian.Game.Chat.savedconfigs & 15) == 0) ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.offline') + '<br>' + '<input type="radio" name="onlinestate" value="2" ' + (((Travian.Game.Chat.savedconfigs & 2) == 2) ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.invisible') + '<br>' + '<input type="radio" name="onlinestate" value="4" ' + (((Travian.Game.Chat.savedconfigs & 4) == 4) ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.invistononally') + '<br>' + '<input type="radio" name="onlinestate" value="8" ' + (((Travian.Game.Chat.savedconfigs & 8) == 8) ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.invistoally') + '<br>' + '<input type="radio" name="onlinestate" value="1" ' + (((Travian.Game.Chat.savedconfigs & 1) == 1) ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.visible') + '</div>' + '<div class="optionsticker">' + Travian.Translation.get('tpw.notifications') + '</div>' + '<div class="optionbox">' + '<input type="checkbox" name="sound" ' + ((Travian.Game.Chat.savedconfigs & 16) == 16 ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.soundnotify') + '<br>' + '<input type="checkbox" name="popup" ' + ((Travian.Game.Chat.savedconfigs & 32) == 32 ? 'checked="checked"' : '') + '>' + Travian.Translation.get('tpw.popupnotify') + '<br>' + '</div>'
        }).addEvent('change', function() {
                ti.enableSaveBtn()
            });
        var btnC = new Element('div', {
            'class': 'chatbuttonborder'
        });
        this.chatconfigformbtn = new Element(new Element('input', {
            'type': 'button',
            'value': Travian.Translation.get('tpw.save'),
            'class': 'chatbutton',
            'disabled': 'disabled'
        })).addEvent('click', function() {
                ti.saveConfigs()
            });
        btnC.appendChild(this.chatconfigformbtn);
        this.chatconfigform.appendChild(btnC);
        this.gui = new Element('div', {
            'class': 'chatconfigs'
        });
        this.gui.appendChild(this.chatconfigform);
        this.gui.inject(Travian.Game.Chat.mainwindow.contentElement)
    },
    enableSaveBtn: function() {
        this.chatconfigformbtn.removeAttribute('disabled')
    },
    saveConfigs: function() {
        this.chatconfigformbtn.setAttribute('disabled', 'disabled');
        var fr = new Form.serialize(this.gui, this.chatconfigform);
        Travian.ajax({
            data: {
                cmd: 'chat',
                a: 'scfg',
                data: fr
            },
            onSuccess: function(data) {
                Travian.Game.Chat.savedconfigs = data
            }
        })
    },
    activate: function() {},
    deactivate: function() {}
});
CChatAllyConversation = new Class({
    gui: {},
    refreshInterval: 5000,
    active: false,
    cboxcontent: {},
    bbBar: {},
    smilies: {},
    cboxinput: {},
    textareaInput: {},
    historyUpdated: 0,
    initialize: function() {
        var b = this;
        this.cboxcontent = new Element('div', {
            'class': 'chatboxcontent ally'
        });
        this.bbBar = new Element('div', {
            'class': 'bbBar'
        });
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbSmilies',
            'events': {
                'click': function() {
                    b.toggleSmiliesDialog()
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbAlli',
            'events': {
                'click': function() {
                    b.insertTag('Alliance')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbPlayer',
            'events': {
                'click': function() {
                    b.insertTag('Player')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbCoor',
            'events': {
                'click': function() {
                    b.insertTag('x|y')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbReport',
            'events': {
                'click': function() {
                    b.insertTag('Report')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbBold',
            'events': {
                'click': function() {
                    b.insertTag('b')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbItalic',
            'events': {
                'click': function() {
                    b.insertTag('i')
                }
            }
        }));
        this.bbBar.appendChild(new Element('div', {
            'class': 'btn bbUnderline',
            'events': {
                'click': function() {
                    b.insertTag('u')
                }
            }
        }));
        this.smilies = new Element('div', {
            'class': 'smilies',
            'style': 'right:20px;',
            'events': {
                'blur': function() {
                    b.toggleSmiliesDialog()
                }
            }
        });
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley aha',
            'events': {
                'click': function() {
                    b.insertTag('*aha*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley angry',
            'events': {
                'click': function() {
                    b.insertTag('*angry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cool',
            'events': {
                'click': function() {
                    b.insertTag('*cool*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cry',
            'events': {
                'click': function() {
                    b.insertTag('*cry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley cute',
            'events': {
                'click': function() {
                    b.insertTag('*cute*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley depressed',
            'events': {
                'click': function() {
                    b.insertTag('*depressed*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley eek',
            'events': {
                'click': function() {
                    b.insertTag('*eek*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley ehem',
            'events': {
                'click': function() {
                    b.insertTag('*ehem*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley emotional',
            'events': {
                'click': function() {
                    b.insertTag('*emotional*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley grin',
            'events': {
                'click': function() {
                    b.insertTag(':D')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley happy',
            'events': {
                'click': function() {
                    b.insertTag(':)')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hit',
            'events': {
                'click': function() {
                    b.insertTag('*hit*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hmm',
            'events': {
                'click': function() {
                    b.insertTag('*hmm*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hmpf',
            'events': {
                'click': function() {
                    b.insertTag('*hmpf*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley hrhr',
            'events': {
                'click': function() {
                    b.insertTag('*hrhr*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley huh',
            'events': {
                'click': function() {
                    b.insertTag('*huh*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley lazy',
            'events': {
                'click': function() {
                    b.insertTag('*lazy*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley love',
            'events': {
                'click': function() {
                    b.insertTag('*love*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley nocomment',
            'events': {
                'click': function() {
                    b.insertTag('*nocomment*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley noemotion',
            'events': {
                'click': function() {
                    b.insertTag('*noemotion*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley notamused',
            'events': {
                'click': function() {
                    b.insertTag('*notamused*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley pout',
            'events': {
                'click': function() {
                    b.insertTag('*pout*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley redface',
            'events': {
                'click': function() {
                    b.insertTag('*redface*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley rolleyes',
            'events': {
                'click': function() {
                    b.insertTag('*rolleyes*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley sad',
            'events': {
                'click': function() {
                    b.insertTag(':(')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley shy',
            'events': {
                'click': function() {
                    b.insertTag('*shy*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley smile',
            'events': {
                'click': function() {
                    b.insertTag('*smile*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley tongue',
            'events': {
                'click': function() {
                    b.insertTag('*tongue*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley veryangry',
            'events': {
                'click': function() {
                    b.insertTag('*veryangry*')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley wink',
            'events': {
                'click': function() {
                    b.insertTag(';)')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r1',
            'events': {
                'click': function() {
                    b.insertTag('[l]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r2',
            'events': {
                'click': function() {
                    b.insertTag('[cl]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r3',
            'events': {
                'click': function() {
                    b.insertTag('[i]')
                }
            }
        }));
        this.smilies.appendChild(new Element('img', {
            'src': 'img/x.gif',
            'class': 'smiley r4',
            'events': {
                'click': function() {
                    b.insertTag('[c]')
                }
            }
        }));
        for (idx = 1; idx <= 50; idx++) {
            var tmpStr = '[tid' + idx + ']';
            var el = new Element('img', {
                'src': 'img/x.gif',
                'alt': tmpStr,
                'class': 'smiley unit u' + idx,
                'events': {
                    'click': function() {
                        b.insertTag(this.alt)
                    }
                }
            });
            this.smilies.appendChild(el)
        }
        document.body.appendChild(this.smilies);
        this.cboxinput = new Element('div', {
            'class': 'chatboxinput'
        });
        this.textareaInput = new Element('textarea', {
            'name': 'alliancetext',
            'id': 'alliancetext',
            'class': 'chatboxtextarea',
            'maxlength': '1023',
            'events': {
                'keyup': function(event) {
                    b.keyboardReader(event)
                },
                'click': function() {
                    b.smilies.setStyle('display', 'none')
                }
            }
        });
        this.cboxinput.appendChild(this.textareaInput);
        this.gui = new Element('div', {
            'class': 'chatallychat'
        });
        this.gui.appendChild(this.cboxcontent);
        this.gui.appendChild(this.bbBar);
        this.gui.appendChild(this.cboxinput);
        this.gui.inject(Travian.Game.Chat.mainwindow.contentElement)
    },
    toggleSmiliesDialog: function() {
        if (this.smilies.getStyle('display') == 'none') {
            this.smilies.setStyle('display', 'block')
        } else {
            this.smilies.setStyle('display', 'none')
        }
    },
    insertTag: function(b) {
        switch (b) {
            case "b":
            case "i":
            case "u":
            case "Alliance":
            case "x|y":
            case "Player":
            case "Report":
                this.textareaInput.insertAroundCursor({
                    before: "[" + b + "]",
                    after: "[/" + b + "]"
                });
                break;
            default:
                this.textareaInput.insertAtCursor(b, false);
                break
        }
    },
    keyboardReader: function(e) {
        if (Travian.Game.Chat.alliance > 0) {
            if (e.key == 'enter' && !e.shift) {
                this.smilies.setStyle('display', 'none');
                this.textareaInput.value = this.textareaInput.value.trim();
                if (this.textareaInput.value.length < 1) {
                    return
                }
                if (this.textareaInput.value.length > 1024) {
                    this.textareaInput.value.value = this.textareaInput.value.value.substring(0, limitNum)
                }
                var message = this.textareaInput.value;
                this.textareaInput.set('value', '');
                var a = this;
                Travian.ajax({
                    data: {
                        'cmd': 'chat',
                        'a': 'asc',
                        'm': encodeURIComponent(message)
                    },
                    onSuccess: function(data) {
                        a.cboxcontent.appendChild(new Element('div', {
                            'class': 'chatmymsgarrow'
                        }));
                        var msgDiv = new Element('div', {
                            'class': 'chatmymsg',
                            'html': data
                        });
                        a.cboxcontent.appendChild(msgDiv);
                        a.cboxcontent.appendChild(new Element('br', {
                            'clear': 'all'
                        }));
                        new Fx.Scroll(a.cboxcontent).toElement(msgDiv)
                    }
                })
            }
        }
    },
    getChatNewMessage: function() {
        if (Travian.Game.Chat.alliance > 0) {
            var a = this;
            Travian.ajax({
                data: {
                    cmd: 'chat',
                    a: 'agnm'
                },
                onSuccess: function(data) {
                    data.each(function(d) {
                        a.cboxcontent.appendChild(new Element('div', {
                            'class': 'chatyourmsgarrow'
                        }));
                        var msgDiv = new Element('div', {
                            'class': 'chatyourmsg',
                            'html': '<a href="spieler.php?uid=' + d.u + '">' + d.n + '</a>:' + d.m + ''
                        });
                        a.cboxcontent.appendChild(msgDiv);
                        a.cboxcontent.appendChild(new Element('br', {
                            'clear': 'all'
                        }));
                        new Fx.Scroll(a.cboxcontent).toElement(msgDiv)
                    })
                }
            });
            if (this.active) setTimeout(function() {
                a.getChatNewMessage()
            }, this.refreshInterval)
        }
    },
    getChatHistory: function(s) {
        if (Travian.Game.Chat.alliance > 0) {
            var a = this;
            this.historyUpdated = 1;
            var fc = a.cboxcontent.getElement(':first-child');
            if (fc && fc.hasClass('chatprevhistory')) {
                fc.set('html', Travian.Translation.get('tpw.wait'))
            }
            Travian.ajax({
                data: {
                    cmd: 'chat',
                    a: 'agch',
                    's': s
                },
                onSuccess: function(data) {
                    var fc = a.cboxcontent.getElement(':first-child');
                    if (fc && fc.hasClass('chatprevhistory')) {
                        fc.dispose()
                    }
                    var f = false;
                    while (d = data.pop()) {
                        a.cboxcontent.grab(new Element('br', {
                            'clear': 'all'
                        }), 'top');
                        var message = d.m;
                        var msgDiv = new Element('div', {
                            'class': (d.n == Travian.Game.Chat.username ? 'chatmymsg' : 'chatyourmsg'),
                            'html': (d.n != Travian.Game.Chat.username ? '<a href="spieler.php?uid=' + d.u + '">' + d.n + '</a>:' : '') + message + ''
                        });
                        if ((f == false) && (s == 0)) f = msgDiv;
                        a.cboxcontent.grab(msgDiv, 'top');
                        a.cboxcontent.grab(new Element('div', {
                            'class': (d.n != Travian.Game.Chat.username ? 'chatyourmsgarrow' : 'chatmymsgarrow')
                        }), 'top')
                    }
                    var fc = a.cboxcontent.getElement(':first-child');
                    if (!fc || !fc.hasClass('chatprevhistory')) {
                        a.cboxcontent.grab(new Element('div', {
                            'class': 'chatprevhistory',
                            'html': Travian.Translation.get('tpw.showprevchat')
                        }).addEvent('click', function() {
                                a.getChatHistory(1)
                            }), 'top')
                    }
                    if ((f != false) && (s == 0)) new Fx.Scroll(a.cboxcontent).toElement(f);
                    a.getChatNewMessage()
                }
            })
        }
    },
    activate: function() {
        if (Travian.Game.Chat.alliance > 0) {
            this.active = true;
            if (this.historyUpdated == 0);
            this.getChatHistory(0)
        }
    },
    deactivate: function() {
        this.active = false;
        this.smilies.setStyle('display', 'none')
    }
});
CChatRequests = new Class({
    gui: {},
    refreshInterval: 1000000,
    active: false,
    initialize: function() {
        this.gui = new Element('div', {
            'class': 'chatrequests'
        });
        this.gui.inject(Travian.Game.Chat.mainwindow.contentElement)
    },
    getFriendRequests: function() {
        var a = this;
        Travian.ajax({
            data: {
                cmd: 'chat',
                a: 'gfrq'
            },
            onSuccess: function(data) {
                var tstr = '';
                data.each(function(d) {
                    tstr += '<div class="friendlistitem"><a href="spieler.php?uid=' + d.u + '" target="_blank">' + d.n + '</a></div>'
                });
                a.gui.set('html', tstr)
            }
        });
        if (this.active) setTimeout(function() {
            a.getFriendRequests()
        }, a.refreshInterval)
    },
    activate: function() {
        this.active = true;
        this.getFriendRequests()
    },
    deactivate: function() {
        this.active = false
    }
});
Travian.Game.Chat = {
    windowFocus: true,
    username: '',
    alliance: 0,
    gpackDir: '',
    chatHeartbeatCount: 0,
    minChatHeartbeat: 1000,
    maxChatHeartbeat: 33000,
    chatHeartbeatTime: 1000,
    originalTitle: '',
    blinkOrder: 0,
    chatboxFocus: new Array(),
    newMessages: new Array(),
    newMessagesWin: new Array(),
    chatBoxes: new Array(),
    friendslist: {},
    allychat: {},
    mainwindow: {},
    configs: {},
    settleElement: {},
    beepmp3: {},
    savedconfigs: 0,
    render: function(gpdir) {
        Travian.Game.Chat.gpackDir = gpdir;
        Travian.Game.Chat.settleElement = $("main_container");
        Travian.Game.Chat.beepmp3 = $('beepmp3');
        Travian.Game.Chat.mainwindow = new CChatMainWindow();
        Travian.Game.Chat.friendslist = new CChatFriendslist();
        Travian.Game.Chat.allychat = new CChatAllyConversation();
        Travian.Game.Chat.requests = new CChatRequests();
        Travian.Game.Chat.configs = new CChatConfigs();
        Travian.Game.Chat.mainwindow.initTabs()
    }
};