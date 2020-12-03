<?php
    //filters//
    if (isset($_GET['routeid'])) {
        $_GET['routeid'] = filter_var($_GET['routeid'], FILTER_SANITIZE_NUMBER_INT);
        $_GET['routeid'] = abs($_GET['routeid']);
    }
    $edited_route = $database->getTradeRoute2($_GET['routeid']); ?>
<form action="build.php" method="post">
    <div class="boxes boxesColor gray">
        <div class="boxes-tl"></div>
        <div class="boxes-tr"></div>
        <div class="boxes-tc"></div>
        <div class="boxes-ml"></div>
        <div class="boxes-mr"></div>
        <div class="boxes-mc"></div>
        <div class="boxes-bl"></div>
        <div class="boxes-br"></div>
        <div class="boxes-bc"></div>
        <div class="boxes-contents cf">
            <input type="hidden" name="action" value="editRoute">
            <input type="hidden" name="routeid" value="<?php echo $_GET['routeid']; ?>">
            <table cellpadding="1" cellspacing="1" id="npc" class="transparent">
                <thead>
                <tr>
                    <th colspan="2"><?php echo MK_EDITROUTE; ?></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th>
                        Resources:
                    </th>
                    <td>
                        <img src="<?php echo GP_LOCATE; ?>img/r/1.gif" alt="Wood" title="<?php echo VL_WOOD; ?>"> <input
                            class="text"
                            type="text"
                            name="r1" id="r1"
                            value="<?php echo $edited_route['wood']; ?>"
                            maxlength="5"
                            tabindex="1"
                            style="width:50px;">
                        <img src="<?php echo GP_LOCATE; ?>img/r/2.gif" alt="Clay" title="<?php echo VL_CLAY; ?>"> <input
                            class="text"
                            type="text"
                            name="r2" id="r2"
                            value="<?php echo $edited_route['clay']; ?>"
                            maxlength="5"
                            tabindex="1"
                            style="width:50px;">
                        <img src="<?php echo GP_LOCATE; ?>img/r/3.gif" alt="Iron" title="<?php echo VL_IRON; ?>"> <input
                            class="text"
                            type="text"
                            name="r3" id="r3"
                            value="<?php echo $edited_route['iron']; ?>"
                            maxlength="5"
                            tabindex="1"
                            style="width:50px;">
                        <img src="<?php echo GP_LOCATE; ?>img/r/4.gif" alt="Wheat" title="<?php echo VL_CROP; ?>">
                        <input class="text"
                               type="text"
                               name="r4"
                               id="r4"
                               value="<?php echo $edited_route['crop']; ?>"
                               maxlength="5"
                               tabindex="1"
                               style="width:50px;">
                    </td>
                </tr>
                <tr>
                    <th>
                        <?php echo MK_STARTTIME; ?>:
                    </th>
                    <td>
                        <select name="start"><?php for ($i = 0; $i <= 23; $i++) { ?>
                                <option value="<?php echo $i; ?>" <?php if ($i == $edited_route['start']) {
                                    echo "selected";
                                } ?>><?php if ($i > 9) {
                                    echo $i;
                                } else {
                                    echo "0" . $i;
                                } ?></option><?php } ?></select>
                    </td>
                </tr>
                <tr>
                    <th>
                        <?php Echo MK_NUMBEROFTIMES;?>:
                    </th>
                    <td>
                        <select name="deliveries"><?php for ($i = 1; $i <= 3; $i++) { ?>
                                <option value="<?php echo $i; ?>" <?php if ($i == $edited_route['deliveries']) {
                                    echo "selected";
                                } ?>><?php echo $i; ?></option><?php } ?></select>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
    <p>
        <button type="submit" value="button" class="green build">
            <div class="button-container addHoverClick">
                <div class="button-background">
                    <div class="buttonStart">
                        <div class="buttonEnd">
                            <div class="buttonMiddle"></div>
                        </div>
                    </div>
                </div>
                <div class="button-content"><?php echo SI_SAVE; ?></div>
            </div>
        </button>
    </p>
</form>
</div>