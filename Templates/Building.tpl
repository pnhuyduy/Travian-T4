<div class="boxes buildingList">
    <div class="boxes-tl"></div>
    <div class="boxes-tr"></div>
    <div class="boxes-tc"></div>
    <div class="boxes-ml"></div>
    <div class="boxes-mr"></div>
    <div class="boxes-mc"></div>
    <div class="boxes-bl"></div>
    <div class="boxes-br"></div>
    <div class="boxes-bc"></div>
    <div class="boxes-contents cf"><h5><?php echo BD_BUILDING; ?></h5>

        <div class="finishNow">
            <button type="button" value="<?php echo BD_COMPCONSIM;?>" id="button527fdfcd482b7" class="gold "
                    title="<?php echo BD_COMPCONSIM;?>">
                <div class="button-container addHoverClick">
                    <div class="button-background">
                        <div class="buttonStart">
                            <div class="buttonEnd">
                                <div class="buttonMiddle"></div>
                            </div>
                        </div>
                    </div>
                    <div class="button-content"><?php echo BD_COMPCONSIM; ?></div>
                </div>
            </button>
            <script type="text/javascript">
                window.addEvent('domready', function () {
                    if ($('button527fdfcd482b7')) {
                        $('button527fdfcd482b7').addEvent('click', function () {
                            window.fireEvent('buttonClicked', [this, {"type": "button", "value": "<?php echo BD_COMPCONSIM;?>", "name": "", "id": "button527fdfcd482b7", "class": "gold ", "title": "<?php echo BD_COMPCONSIM;?>", "confirm": "", "onclick": "", "dialog": {"saveOnUnload": false, "cssClass": "white", "draggable": false, "overlayCancel": true, "buttonOk": false, "data": {"cmd": "finishNowPopup"}, "context": "finishNow", "infoIcon": "http:\/\/t4.answers.travian.com\/index.php?aid=372#go2answer"}}]);
                        });
                    }
                });
            </script>
        </div>
        <?php
            if (!isset($timer)) {
                $timer = 1;
            }
            foreach ($building->buildArray as $jobs) {
                echo "<ul>";
                if ($jobs['master'] == 0) {
                    echo "<li><a href=\"?d=" . $jobs['id'] . "&a=0&c=$session->checker\">";
                    echo "<img src=\"img/x.gif\" class=\"del\" title=\"".BD_CANCEL."\" alt=\"".BD_CANCEL."\" /></a>";
                    echo "<div class=\"name\">" . $building->procResType($jobs['type']) . " <span class=\"lvl\"> " .BD_LEVEL. ($village->resarray['f' . $jobs['field']] + ($jobs['field'] == $BuildFirst ? 2 : 1)) . "</span></div>";
                    if ($jobs['loopcon'] == 0) {
                        $BuildFirst = $jobs['field'];
                    }
                    if ($jobs['loopcon'] == 1) {
                        echo " (waiting loop) ";
                    }
                    echo "<div class=\"buildDuration\"><span id=\"timer" . $timer . "\">";
                    echo $generator->getTimeFormat($jobs['timestamp'] - time());
                    echo "</span> ساعت. ";
                    echo "زمان اتمام " . date('H:i', $jobs['timestamp']) . "</div><div class=\"clear\"></div></li>";
                    $timer += 1;
                } else {
                    echo "<li><a href=\"?d=" . $jobs['id'] . "&a=0&c=$session->checker\">";
                    echo "<img src=\"img/x.gif\" class=\"del\" title=\"cancel\" alt=\"cancel\" /></a>";
                    echo "<div class=\"name\">" . $building->procResType($jobs['type']) . " <span class=\"lvl\"> " .BD_LEVEL. $jobs['level'] . "</span></div><span class=\"name\"> (".BD_BUILDMASTER.") </span><div class=\"clear\"></div></li>";
                }
                echo "<ul>";
            }
        ?>
    </div>
</div>
<script type="text/javascript">var bld = [
        {"stufe": 1, "gid": "4", "aid": "2"}
    ]</script>