var InitiateEasyPieChart = function () {
    return {
        init: function () {
            var easypiecharts = $('.easyPieChart');
            $.each(easypiecharts, function () {
                $(this).easyPieChart({
                    barColor: 'green',
                    trackColor: 'white',
                    scaleColor: 'yellow',
                    lineCap: 'butt'
                });
            });
        }
    };
}();
