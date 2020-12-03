<script type="text/javascript">
    window.addEvent('domready', function () {
        $$('.subNavi').each(function (element) {
            new Travian.Game.Menu(element);
        });
    });
</script>
<script type="text/javascript">
    window.addEvent('domready', function () {
        "use strict";

        var renderIgnoreList = function () {
            Travian.ajax({
                data: {
                    cmd: 'ignoreList',
                    method: 'render_ignore_list'
                },

                onSuccess: function (response) {
                    if (response.result !== undefined) {
                        $$('#ignore-list').set('html', response.result);
                    }
                }
            });
        };

        renderIgnoreList();
    });

    var unignoreUser = function (targetPlayer) {
        Travian.ajax({
            data: {
                cmd: 'ignoreList',
                method: 'stop_ignore_target_player',
                renderIgnoreList: true,
                params: {
                    targetPlayer: targetPlayer
                }
            },

            onSuccess: function (response) {
                if ((response.error === undefined || !response.error) && response.result !== undefined) {
                    $$('#ignore-list').set('html', response.result);
                }
            }
        });

        return false;
    };
</script>

<div class="ignoreListContainer" id="ignore-list">
    <div id="ignore-list-columns">
    </div>
    <div class="clear"></div>
    <div>
        <table>
            <tfoot>
            <tr>
                <td colspan="6">
                    0/20
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <?php echo MS_IGNOREDESC;?>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
    <div class="clear"></div>
</div>
<br/>
<span></span>