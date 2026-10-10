window.weatherInterop = {
    getCurrentPosition: function () {
        return new Promise(function (resolve, reject) {
            if (!navigator.geolocation) {
                reject(new Error("A böngésző nem támogatja a helymeghatározást."));
                return;
            }

            navigator.geolocation.getCurrentPosition(
                function (position) {
                    resolve({
                        latitude: position.coords.latitude,
                        longitude: position.coords.longitude
                    });
                },
                function (error) {
                    reject(new Error(error.message || "A helymeghatározás sikertelen."));
                },
                {
                    enableHighAccuracy: false,
                    timeout: 10000,
                    maximumAge: 300000
                }
            );
        });
    },

    loadFavorites: function (key) {
        return window.localStorage.getItem(key);
    },

    saveFavorites: function (key, json) {
        window.localStorage.setItem(key, json);
    }
};
