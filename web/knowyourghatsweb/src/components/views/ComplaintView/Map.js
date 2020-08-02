import React, { Component } from 'react';
import { Map, GoogleApiWrapper, InfoWindow, Marker } from 'google-maps-react';

const mapStyles = {
    width: '4oopx',
    height: '400px',
    position: 'relative', 
  };

  const containerStyle = {
    position: 'relative',  
    width: '75%',
    height: '100%',
    marginTop: '30px',
    marginBottom: '30px',
    marginLeft: 'auto',
    marginRight: 'auto'
  }

 export class MapView extends Component {
    state = {
        showingInfoWindow: false,  //Hides or the shows the infoWindow
        activeMarker: {},          //Shows the active marker upon click
        selectedPlace: {}          //Shows the infoWindow to the selected place upon a marker
      };
      onMarkerClick = (props, marker, e) =>
      this.setState({
        selectedPlace: props,
        activeMarker: marker,
        showingInfoWindow: true
      });
    
    onClose = props => {
      if (this.state.showingInfoWindow) {
        this.setState({
          showingInfoWindow: false,
          activeMarker: null
        });
      }
    };
    render() {
      return (
        
        <Map
          google={this.props.google}
          zoom={14}
          containerStyle={containerStyle}
          style={mapStyles}
          initialCenter={{
           lat: this.props.latitude,
           lng: this.props.longitude
          }}
        >
        <Marker
          onClick={this.onMarkerClick}
          name={'Ganga Mahal Gate'}
        />
        <InfoWindow
          marker={this.state.activeMarker}
          visible={this.state.showingInfoWindow}
          onClose={this.onClose}
        >
          <div>
            <h5>{this.state.selectedPlace.name}</h5>
          </div>
        </InfoWindow>
        </Map>  
          
      );
    }
  }
  
  export default GoogleApiWrapper({
    apiKey: 'AIzaSyArhvQkAsXMJTOHfz2_n9Lsbze7hDDWIGc'
  })(MapView);



  