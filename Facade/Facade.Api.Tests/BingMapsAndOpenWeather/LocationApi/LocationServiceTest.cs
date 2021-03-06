using System;
using Facade.Logic;
using Facade.Logic.BingMapsAndOpenWeather.LocationApi;
using Xunit;

namespace Facade.Api.Tests.BingMapsAndOpenWeather.LocationApi
{
    public class LocationServiceTest
    {
        private readonly string? ApiKey = Environment.GetEnvironmentVariable("BINGMAPS_APIKEY");

        [Fact]
        public void GetLocation__ReturnsGpsCoordinates()
        {
            var locationService = new LocationService();
            var locations = locationService.GetLocations("Roermond NL", "0", "", 1, ApiKey);

            Assert.True(!double.IsNaN(locations[0].point.coordinates[0]));
            Assert.True(!double.IsNaN(locations[0].point.coordinates[1]));
        }

        [Fact]
        public void GetLocation_InvalidApiKey_ThrowsUnexpectedApiResponseException()
        {
            var locationService = new LocationService();
            Assert.Throws<UnexpectedApiResponseException>(() =>
                locationService.GetLocations("", "", "", 0, "INVALID API KEY"));
        }
    }
}