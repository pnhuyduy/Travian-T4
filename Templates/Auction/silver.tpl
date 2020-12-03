<script type="text/javascript">
    Element.implement({
        showOrHide: function (imgid) {
            //einblenden
            if (this.getStyle('display') == 'none') {
                if (imgid != '') {
                    $(imgid).className = 'open2';
                }
            }
            //ausblenden
            else {
                if (imgid != '') {
                    $(imgid).className = 'close2 ';
                }
            }
            this.toggleClass('hide');
        }
    });
</script>
<table cellpadding="1" cellspacing="1" id="silverAccounting">
    <thead>
    <tr>
        <th class="date"><?php echo HR_DATE; ?></th>
        <th class="cause"><?php echo HR_REASON; ?></th>
        <th class="accounting"><?php echo HR_BOOKING; ?></th>
        <th class="balance"><?php echo HR_BALANCE; ?></th>
    </tr>
    </thead>
    <tbody>
    <?php
        $q = "SELECT * FROM " . TB_PREFIX . "silver_accounting where wref = " . $_SESSION['wid'] . "";
        $bid = 0;
        //$dataarray = $database->query_return($q);
        //foreach($dataarray as $dbarray){
        $res = mysql_query($q);
        if ($res) {
            while ($data = mysql_fetch_assoc($res)) {
                if ($dbarray['date'] <= time() + 604800) {
                    $bid++;
                    $td += $dbarray['used'];
                    $ts += $dbarray['balance'];
                }
            }
        }
        if ($bid != 0) {
            ?>
            <td colspan="2" style="background-color:#edeceb;">
                <a onClick="$('setResource').showOrHide('arrow');$('hidehero').showOrHide('arrow');$('exp').showOrHide('arrow');"
                   class="showPWForgottenLink">
                    <img class="open2" id="arrow" src="img/x.gif"> <font color=black> <?php echo HR_DEALING; ?> </font></a>
                <br/>
                <br/></div>
            </td>
            <td style="background-color:#edeceb;"><?php echo $td; ?></td>
            <td style="background-color:#edeceb;"><?php echo $ts; ?></td>
            </tr>
        <?php
        }
        //foreach($dataarray as $dbarray) {
        $res = mysql_query($q);
        if ($res) {
            while ($data = mysql_fetch_assoc($res)) {
                if ($dbarray['date'] <= time() + 604800) {
                    $bid++;
                    ?>
                    <tr class="hover">
                        <td><?php echo date("j. M", $dbarray['date']); ?></td>

                        <td><?php echo $dbarray['reason']; ?></td>

                        <td><?php if ($dbarray['used'] <= 0) {
                                echo $dbarray['used'];
                            } else {
                                echo "+" . $dbarray['used'];
                            } ?></td>

                        <td><?php echo $dbarray['balance']; ?></td>
                    </tr>
                <?php
                }
            }
        }
        if ($bid == 0){
    ?>
    <tbody class="latestBookings">
    <tr>
        <td colspan="4" class="noData"><?php echo HR_NOBOOKING;?>
        </td>
    </tr>
    </tbody>
    <tbody>
    <tr class="oldBalance">
        <td colspan="4" class="oldBalance"><span class="balanceSince"><?php echo HR_DEALING;?></span></td>
    </tr>
    <?php
        }
    ?>
    </tbody>
</table>
</tr>