<form method="post" action="build.php">
    <table cellpadding="1" cellspacing="1" id="found" class="transparent">
        <input type="hidden" name="id" value="<?php echo $id; ?>">
        <input type="hidden" name="ft" value="ali1">

        <div class="clear"></div>
        <h4 class="round"><?php echo AL_CREATEALLIANCE; ?></h4>
        <tbody>
        <tr>
            <th><?php echo AL_TAG; ?>:</th>
            <td class="tag">
                <input class="text" name="ally1" value="<?php echo $form->getValue("ally1"); ?>" maxlength="8">
                <span class="error"><?php echo $form->getError("ally1"); ?></span>

            </td>
        </tr>
        <tr>
            <th><?php echo AL_NAME; ?>:</th>
            <td class="nam">
                <input class="text" name="ally2" value="<?php echo $form->getValue("ally2"); ?>" maxlength="25">
                <span class="error"><?php echo $form->getError("ally2"); ?></span>
            </td>

        </tr>
        </tbody>
    </table>
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
                <div class="button-content"><?php echo AL_CREATE;?></div>
            </div>
        </button>
    </p>
</form>
    
