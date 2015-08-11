UFlying.controller('dialogs.Marriage', function ($scope, $modalInstance, cities, data, $timeout, $http) {
    $scope.cancel = function() {
        $modalInstance.dismiss('Canceled');
    }

    $scope.submit = function () {
        $scope.money = '￥1000.00';
        $scope.user = 'G0000000005';
        $scope.phone = '1868618666';
        $scope.timeDescript = $scope.dateText;
        $scope.page = 'summary';
    }

    $scope.edit = function () {
        $scope.page = 'form';
    }

    $scope.provinceChange = function () {
        var province = _.find($scope.provinces, function (prov) {
            return prov.name == $scope.province;
        });

        if (_.isUndefined(province)) return;

        $scope.cities = province.cities;
        $scope.city = $scope.cities.length > 0 ? $scope.cities[0] : null;
        $scope.cityChange();
    }

    $scope.cityChange = function () {
        $scope.address = '';
    }

    $scope.open = function() {
      $timeout(function() {
        $scope.opened = true;
      });
    };

    cities.load(function (data) {
        var provinces = [];
        for (var province in data) {
            provinces.push({
                name: province,
                cities: data[province]
            });
        }

        $scope.provinces = provinces;
        
        $scope.province = provinces.length > 0 ? provinces[0].name : null;
        $scope.cities = provinces.length > 0 ? provinces[0].cities : [];
        $scope.city = $scope.cities[0];
    });

    $scope.dateOptions = {
      'year-format': "'yy'",
      'starting-day': 1,
      'show-weeks': false,
      'current-text': '今天',
      'clear-text': '清空',
      'close-text': '完成'
    };

    var _dateTemplate = _.template('<%=year%>年<%=month%>月<%=date%>日');

    var date = $scope.date = new Date();
    $scope.dateText = _dateTemplate({
        year: date.getFullYear(),
        month: date.getMonth() + 1,
        date: date.getDate()
    });

    $scope.startTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 8, 0);
    $scope.endTime = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 17, 0);

    $scope.page = 'form';
})