class VehicleMap extends React.Component {
  generateColor() {
    let r = Math.floor(Math.random() * 255);
    let g = Math.floor(Math.random() * 255);
    let b = Math.floor(Math.random() * 255);
    return "rgb("+r+" ,"+g+","+ b+")";
  }

  pinMarkup(color) {
    return `<span class="Marker" style="background-color: ${color}"></span>`
  }

  addVehiclePath(map, vehicle) {
    let color = this.generateColor();

    let icon = L.divIcon({
      className: '',
      html: this.pinMarkup(color)
    });

    if (vehicle.locations.length) {
      let coords = Array.prototype.map.call(vehicle.locations, l => [l.lat, l.lng]);

      let line = L.polyline(coords, { color: color, weight: 4 });
      let marker = L.marker(coords.slice(-1).pop(), {icon: icon})
      let vehiclePath = L.layerGroup([line, marker]);

      map.addLayer(vehiclePath);
    }
  }

  componentDidUpdate() {
    let map = L.map('map').setView([52.53, 13.403], 13);

    L.tileLayer('http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    for (var index = 0; index < this.state.vehicles.length; index++) {
      let vehicle = this.state.vehicles[index];

      this.addVehiclePath(map, vehicle)
    }
  }

  componentDidMount() {
    axios.get('/vehicles.json')
      .then(res => {
        const vehicles = res.data;
        this.setState({ vehicles });
      });
  }

  render() {
    return <div id="map"></div>
  }
}
