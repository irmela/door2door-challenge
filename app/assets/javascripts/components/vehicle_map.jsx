const radius = 3500;
const d2dOffice = [52.53, 13.403];

class VehicleMap extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      vehicles: []
    };
  }

  componentDidMount(){
    this.buildMap();

    this.timer = setInterval(()=> this.getVehicles(), 3000)
  }

  componentWillUpdate() {
    // ToDo: only update when vehicle state changed
    this.vehicleLayers.clearLayers();
    this.addVehicles(this.map);
  }

  getVehicles() {
    axios.get('/vehicles.json')
      .then(res => {
        const vehicles = res.data;
        this.setState({ vehicles });
      })
      .catch(function (error) {
        console.log(error);
      });
  }

  registerVehicle(vehicle) {
    axios.post('/vehicles', { id: vehicle.uuid })
      .catch(function (error) {
        console.log(error);
      });
  }

  deregisterVehicle(vehicle) {
    axios.delete(`/vehicles/${vehicle.uuid}`)
      .catch(function (error) {
        console.log(error);
      });
  }

  buildMap() {
    var map = this.map = L.map('map').setView(d2dOffice, 13);

    L.tileLayer('http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let homeIcon = L.divIcon({className: 'Marker Marker--home', iconSize: [40, 40]});
    L.marker(d2dOffice, {icon: homeIcon}).addTo(map);

    this.boundary = L.circle(d2dOffice, {radius: radius, color: '#003552'}).addTo(map);

    this.vehicleLayers = L.markerClusterGroup().addTo(map);
  }

  addVehicles() {
    for (var index = 0; index < this.state.vehicles.length; index++) {
      let vehicle = this.state.vehicles[index];

      this.addVehiclePath(this.map, vehicle, this.boundary)
    }
  }

  addVehiclePath(map, vehicle, boundary) {
    let color = this.generateColor(vehicle.uuid);

    let icon = L.divIcon({
      className: '',
      html: this.buildPinMarker(color)
    });

    if (vehicle.locations.length) {
      let coords = Array.prototype.map.call(vehicle.locations, l => [l.lat, l.lng]);
      let latestCoords = coords.slice(-1).pop();

      if (L.latLng(latestCoords).distanceTo(d2dOffice) <= radius) {
        if (!vehicle.moving) this.registerVehicle(vehicle)

        L.polyline(coords, { color: color, weight: 4 }).addTo(this.vehicleLayers);
        L.marker(latestCoords, {icon: icon}).bindPopup(this.buildPopup(vehicle)).addTo(this.vehicleLayers);
      } else {
        if (vehicle.moving) this.deregisterVehicle(vehicle)
      }
    }
  }

  generateColor(uuid) {
    return '#' + uuid.substring(1,7);
  }

  buildPinMarker(color) {
    return `<span class="Marker Marker--pin" style="background-color: ${color}"></span>`
  }

  buildPopup(vehicle) {
    latestLocation = vehicle.locations.slice(-1).pop();
    return `<b>Vehicle:</b> ${vehicle.uuid}<br />
            <b>Time:</b> ${latestLocation.at}<br />
            <b>Position:</b> ${latestLocation.lat}, ${latestLocation.lng}`
  }

  render() {
    return <div id="map"></div>
  }
}
