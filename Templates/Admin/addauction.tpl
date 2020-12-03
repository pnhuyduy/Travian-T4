<?php
$items = array(
    array("name" => "",
        "pname" => ""
    ),
    array("name" => "helmet",
        "pname" => "helmet"
    ),
    array("name" => "body",
        "pname" => "body items"
    ),
    array("name" => "leftHand",
        "pname" => "leftHand items"
    ),
    array("name" => "rightHand",
        "pname" => "rightHand items"
    ),
    array("name" => "shoes",
        "pname" => "shoes items"
    ),
    array("name" => "horse",
        "pname" => "horse"
    ),
    array("name" => "bandage25",
        "pname" => "Small bandage"
    ),
    array("name" => "bandage33",
        "pname" => "bandage"
    ),
    array("name" => "cage",
        "pname" => "Cage"
    ),
    array("name" => "scroll",
        "pname" => "Scroll's;"
    ),
    array("name" => "ointment",
        "pname" => "ointment"
    ),
    array("name" => "bucketOfWater",
        "pname" => "bucket Of Water"
    ),
    array("name" => "bookOfWisdom",
        "pname" => "book Of Wisdom"
    ),
    array("name" => "lawTables",
        "pname" => "law Tables"
    ),
    array("name" => "artWork",
        "pname" => "artWork"
    )
);

$status = "";
if (isset($_POST['submitted']) && $_POST['submitted'] == "yes") {
    /*if (isset($_POST["time"]) && !$_POST["time"] == "" && is_numeric($_POST['time'])) {
        $mtime = $_POST['time'] * 60 * 60;
    } else {
        $mtime = 60 * 60;
    }*/
    mysql_query("UPDATE " . TB_PREFIX . "autoauction SET active = 0") or die(mysql_error());
    for ($y = 1; $y < 16; $y++) {
        if (isset($_POST[$y . "_c"]) && !$_POST[$y . "_c"] == "") {
            if (isset($_POST[$y . "_n"]) && is_numeric($_POST[$y . "_n"]) && $_POST[$y . "_n"] > 0) {
                $btype = $_POST[$y . "_c"];
                $item_id = $y;
                $item_qty = $_POST[$y . "_n"];
                $item_time = $_POST[$y . "_t"];
                $qty = $item_qty;

                mysql_query("UPDATE " . TB_PREFIX . "autoauction SET active = 1, number = '" . $item_qty . "', time = '" . $item_time . "' WHERE id = " . $item_id) or die(mysql_error());


            }
        }
    }
}
?>

<form action="" method="post">
    <input type="hidden" name="submitted" value="yes">
    <table>
        <tr>
            <td></td>
            <td>Icon</td>
            <td>Item Name</td>
            <td>Number</td>
            <td>Time</td>
        </tr>

        <?php
        $res = mysql_query("SELECT * FROM " . TB_PREFIX . "autoauction");
        $rows[0] = '';
        while ($array = mysql_fetch_assoc($res)) {
            $rows[] = $array;
        }
        for ($i = 1; $i < 16; $i++) {
            echo '<tr>';
            if (($rows[$i]['active'] == 1)) {
                $checked = "checked";
            } else {
                $checked = "";
            }
            echo '<td><input type="checkbox" ' . $checked . ' name="' . $i . '_c" value="' . $i . '"></td>';
            echo '<td><img src="img/x.gif" class="itemCategory itemCategory_' . $items[$i]['name'] . '"></td>';
            echo '<td>' . $items[$i]['pname'] . '</td>';
            echo '<td>' . '<input type="number" name="' . $i . '_n" value="' . $rows[$i]['number'] . '">' . '</td>';
            echo '<td>' . '<input type="text" size="5" name="' . $i . '_t" value="' . $rows[$i]['time'] . '">' . ' hour</td>';
            echo '</tr>';
        };


        ?>
    </table>
    <br>
    <input type="submit" value="Submit">
</form>

<?php
if ($status != "") {
    echo $status;
}
?>
