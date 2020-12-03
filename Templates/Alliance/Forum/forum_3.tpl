<?php
//////////////// made by TTMTT ////////////////
    if ($session->access != BANNED) {
        $topic_id = $_GET['idt'];
        $show_topic = $database->ShowTopic($topic_id);
        foreach ($show_topic as $topi) {
            $title = stripslashes($topi['title']);
        }
        ?>
        <form method="post" action="allianz.php?s=2&fid=<?php echo $_GET['idf']; ?>&pid=<?php echo $aid; ?>">
            <input type="hidden" name="s" value="2">
            <input type="hidden" name="tid" value="<?php echo $topic_id; ?>">
            <input type="hidden" name="edittopic" value="1">

            <table cellpadding="1" cellspacing="1" id="edit_topic">
                <thead>
                <tr>
                    <th colspan="2"><?php echo AL_EDITTOPIC;?>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th><?php echo AL_THREAD;?>:</th>

                    <td><input class="text" type="Text" name="thema" value="<?php echo $title; ?>" maxlength="35"></td>
                </tr>
                <tr>
                    <td>Move topic </td>
                        <td><select class="dropdown" name="fid">
                                <?php
                                    $show_cat = $database->ForumCat($session->alliance);
                                    foreach ($show_cat as $cats) {
                                        if ($cats['id'] == $_GET['idf']) {
                                            echo '<option value="' . $cats['id'] . '" selected>' . stripslashes($cats['forum_name']) . '</option>';
                                        } else {
                                            echo '<option value="' . $cats['id'] . '">' . stripslashes($cats['forum_name']) . '</option>';
                                        }
                                    }
                                ?>
                            </select></td>
                </tr>
                </tbody>
            </table>

            <p>
                <button type="submit" value="ok" name="s1" id="btn_ok" class="green ">
                    <div class="button-container addHoverClick">
                        <div class="button-background">
                            <div class="buttonStart">
                                <div class="buttonEnd">
                                    <div class="buttonMiddle"></div>
                                </div>
                            </div>
                        </div>
                        <div class="button-content"><?php echo OK;?></div>
                    </div>
                </button>
                <script type="text/javascript">
                    window.addEvent('domready', function () {
                        if ($('btn_ok')) {
                            $('btn_ok').addEvent('click', function () {
                                window.fireEvent('buttonClicked', [this, {"type": "submit", "value": "ok", "name": "s1", "id": "btn_ok", "class": "green ", "title": "", "confirm": "", "onclick": ""}]);
                            });
                        }
                    });
                </script>
        </form></p>
    <?php
    } else {
        header("Location: banned.php");
        die;
    }
?>