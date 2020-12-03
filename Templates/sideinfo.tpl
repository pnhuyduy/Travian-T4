<?php
    $x = $x2 = $x3 = $x4 = 0;
    for ($t = 19; $t <= 40; $t++) {
        if ($village->resarray['f' . $t . 't'] == 17) {
            $x = $t;
            //break;
        }
        if ($village->resarray['f' . $t . 't'] == 19) {
            $x2 = $t;
            //break;
        }
        if ($village->resarray['f' . $t . 't'] == 20) {
            $x3 = $t;
            //break;
        }
        if ($village->resarray['f' . $t . 't'] == 21) {
            $x4 = $t;
            //break;
        }
    }
?>
<div class="sidebarBoxInnerBox">
    <div class="innerBox header ">
        <button type="button" id="button5229e5254faf9" class="layoutButton <?php if (!$session->plus) {
            echo 'workshopBlack';
        } else {
            echo 'workshopWhite';
        }
            if ($session->plus) {
                echo " green";
            } else {
                echo " gold";
            }
            if ($x4 == 0) {
                echo ' disabled';
            } ?>" onclick="return false;" title="<?php if (!$session->plus) {
            echo SI_DIRECTLINK."<br>";
        }
            if ($x4 == 0) {
                echo "<span class='warning'>".SI_BUILDWORKSHOP."</span>";
            } ?>">
            <div class="button-container addHoverClick">
                <img src="img/x.gif" alt=""/>
            </div>
        </button>

        <script type="text/javascript">
            <?php if($x4 != 0 && $session->plus){ ?>
            window.addEvent('domready', function () {
                var button = $('button5229e5254faf9');
                if (button) {
                    var titleFunction = function () {
                        button.removeEvent('mouseenter', titleFunction);
                        Travian.Game.Layout.loadLayoutButtonTitle(button, 'activeVillage', 'workshopWhite');
                    };
                    button.addEvent('mouseenter', titleFunction);
                }
            });
            <?php } ?>
            if ($('button5229e5254faf9')) {
                $('button5229e5254faf9').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "<?php if($x4 == 0){ echo 'gold';}else{ echo 'green';}?>", "onclick": "return false;", "loadTitle":<?php if($x4 == 0){ echo 'false';}else{ echo 'true';}?>, "boxId": "activeVillage", "disabled": true, "speechBubble": "", "class": "", "id": "button5229e5254ffa5", "redirectUrl": "<?php if($x4 != 0 && $session->plus){ echo 'build.php?id='.$x4; }?>", "redirectUrlExternal": "" <?php if(!$session->plus){ echo ',"plusDialog":{"featureKey":"directLinks","infoIcon":"http:/\/	4.answers.travian.com\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}';}?>}]);
                });
            }
        </script>
        <button type="button" id="button5229e5254fc5c" class="layoutButton <?php if (!$session->plus) {
            echo 'stableBlack';
        } else {
            echo 'stableWhite';
        }
            if ($session->plus) {
                echo " green";
            } else {
                echo " gold";
            }
            if ($x3 == 0) {
                echo ' disabled';
            } ?>" onclick="return false;" title="<?php if (!$session->plus) {
            echo SI_DIRECTLINK."<br>";
        }
            if ($x3 == 0) {
                echo "<span class='warning'>".SI_BUILDSTABLEP."</span>";
            } ?>">
            <div class="button-container addHoverClick">
                <img src="img/x.gif" alt=""/>
            </div>
        </button>

        <script type="text/javascript">
            <?php if($x3 != 0 && $session->plus){ ?>
            window.addEvent('domready', function () {
                var button = $('button5229e5254fc5c');
                if (button) {
                    var titleFunction = function () {
                        button.removeEvent('mouseenter', titleFunction);
                        Travian.Game.Layout.loadLayoutButtonTitle(button, 'activeVillage', 'stableWhite');
                    };
                    button.addEvent('mouseenter', titleFunction);
                }
            });
            <?php } ?>
            if ($('button5229e5254fc5c')) {
                $('button5229e5254fc5c').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "<?php if($x3 == 0){ echo 'gold';}else{ echo 'green';}?>", "onclick": "return false;", "loadTitle":<?php if($x3 == 0){ echo 'false';}else{ echo 'true';}?>, "boxId": "activeVillage", "disabled": true, "speechBubble": "", "class": "", "id": "button5229e5254ffa5", "redirectUrl": "<?php if($x3 != 0 && $session->plus){ echo 'build.php?id='.$x3; }?>", "redirectUrlExternal": "" <?php if(!$session->plus){ echo ',"plusDialog":{"featureKey":"directLinks","infoIcon":"http:/\/	4.answers.travian.com\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}';}?>}]);
                });
            }
        </script>
        <button type="button" id="button5229e5254fe6f" class="layoutButton <?php if (!$session->plus) {
            echo 'barracksBlack';
        } else {
            echo 'barracksWhite';
        }
            if ($session->plus) {
                echo " green";
            } else {
                echo " gold";
            }
            if ($x2 == 0) {
                echo ' disabled';
            } ?>" onclick="return false;" title="<?php if (!$session->plus) {
            echo SI_DIRECTLINK."<br>";
        }
            if ($x2 == 0) {
                echo "<span class='warning'>".SI_BUILDBARRACKS."</span>";
            } ?>">
            <div class="button-container addHoverClick">
                <img src="img/x.gif" alt=""/>
            </div>
        </button>

        <script type="text/javascript">
            <?php if($x2 != 0 && $session->plus){ ?>
            window.addEvent('domready', function () {
                var button = $('button5229e5254fe6f');
                if (button) {
                    var titleFunction = function () {
                        button.removeEvent('mouseenter', titleFunction);
                        Travian.Game.Layout.loadLayoutButtonTitle(button, 'activeVillage', 'barracksWhite');
                    };
                    button.addEvent('mouseenter', titleFunction);
                }
            });
            <?php } ?>
            if ($('button5229e5254fe6f')) {
                $('button5229e5254fe6f').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "<?php if($x2 == 0){ echo 'gold';}else{ echo 'green';}?>", "onclick": "return false;", "loadTitle":<?php if($x2 == 0){ echo 'false';}else{ echo 'true';}?>, "boxId": "activeVillage", "disabled": true, "speechBubble": "", "class": "", "id": "button5229e5254ffa5", "redirectUrl": "<?php if($x2 != 0 && $session->plus){ echo 'build.php?id='.$x2; }?>", "redirectUrlExternal": "" <?php if(!$session->plus){ echo ',"plusDialog":{"featureKey":"directLinks","infoIcon":"http:/\/	4.answers.travian.com\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}';}?>}]);
                });
            }
        </script>
        <button type="button" id="button5229e5254ffa6" class="layoutButton <?php if (!$session->plus) {
            echo 'marketBlack';
        } else {
            echo 'marketWhite';
        }
            if ($session->plus) {
                echo ' green';
            } else {
                echo ' gold';
            }
            if ($x == 0) {
                echo ' disabled';
            } ?>" onclick="return false;" title="<?php if (!$session->plus) {
            echo SI_DIRECTLINK."<br>";
        }
            if ($x == 0) {
                echo "<span class='warning'>".SI_BUILDMARKET."</span>";
            } ?>">

            <div class="button-container addHoverClick">
                <img src="img/x.gif" alt=""/>
            </div>
        </button>

        <script type="text/javascript">
            <?php if($x != 0 && $session->plus){ ?>
            window.addEvent('domready', function () {
                var button = $('button5229e5254ffa6');
                if (button) {
                    var titleFunction = function () {
                        button.removeEvent('mouseenter', titleFunction);
                        Travian.Game.Layout.loadLayoutButtonTitle(button, 'activeVillage', 'marketWhite');
                    };
                    button.addEvent('mouseenter', titleFunction);
                }
            });
            <?php } ?>
            if ($('button5229e5254ffa6')) {
                $('button5229e5254ffa6').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "<?php if($x == 0){ echo 'gold';}else{ echo 'green';}?>", "onclick": "return false;", "loadTitle":<?php if($x == 0){ echo 'false';}else{ echo 'true';}?>, "boxId": "activeVillage", "disabled": false, "speechBubble": "", "class": "", "id": "button5229e5254ffa6", "redirectUrl": "<?php if($x != 0 && $session->plus){ echo 'build.php?id='.$x; }?>", "redirectUrlExternal": "" <?php if(!$session->plus){ echo ',"plusDialog":{"featureKey":"directLinks","infoIcon":"http:/\/	4.answers.travian.com\/index.php?aid=\u062a\u0639\u0644\u0651\u0645 \u0627\u0644\u0645\u0632\u064a\u062f#go2answer"}';}?>}]);
                });
            }
        </script>
        <div class="clear"></div>
        <div id="villageNameField" class="boxTitle"><?php echo $village->vname; ?></div>
    </div>
    <div class="innerBox content">
        <?php
            switch ($village->loyalty) {
                case $village->loyalty > '100':
                    $style = 'high';
                    break;
                case $village->loyalty <= '100':
                    $style = 'high';
                    break;
                case $village->loyalty <= '50':
                    $style = 'medium';
                    break;
                case $village->loyalty <= '20':
                    $style = 'low';
                    break;
            }?>
        <div class="loyalty <?php echo $style; ?>">
            <?php echo SI_LOYALTY;?>: <span>&#8207;<?php echo $village->loyalty; ?>%&#8207;</span>
        </div>
    </div>
    <div class="innerBox footer">
        <button type="button" id="button5229e5255021d" class="layoutButton editWhite green  " onclick="return false;"
                title="<?php echo SI_CHANGEVILNAME;?>">
            <div class="button-container addHoverClick">
                <img src="img/x.gif" alt=""/>
            </div>
        </button>
        <script type="text/javascript">
            if ($('button5229e5255021d')) {
                $('button5229e5255021d').addEvent('click', function () {
                    window.fireEvent('buttonClicked', [this, {"type": "green", "onclick": "return false;", "loadTitle": false, "boxId": "", "disabled": false, "speechBubble": "", "class": "", "id": "button5229e5255021d", "redirectUrl": "", "redirectUrlExternal": "", "title": "<?php echo SI_CHANGEVILNAME;?>", "villageDialog": {"title": "<?php echo SI_CHANGEVILNAME;?>", "description": "<?php echo SI_NEWVILNAME;?>", "saveText": "<?php echo SI_SAVE;?>", "villageId": "<?php echo $village->wid;?>"}}]);
                });
            }
        </script>
    </div>
</div>
