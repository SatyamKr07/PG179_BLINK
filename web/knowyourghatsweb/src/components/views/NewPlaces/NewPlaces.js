import React, { Component } from 'react';
import DisplayCard from "./DisplayCard/DisplayCard";
import {  MDBRow, MDBCol,  MDBContainer } from "mdbreact";
import { firestore } from "../../../firebase";

class NewPlaces extends Component {
    constructor(props) {
        super(props);
        this.state = {
            newplaces : []
        };
    };

    componentDidMount(){
        var db = firestore;
        db.collection("AddPlaces").get().then((snapshot) => {
            const newState = [];
            snapshot.forEach((newplace) => {
                //console.log(`${newplace.id} => ${newplace.data().name}`);
                newState.push({
                            date: newplace.data().date.toDate().toDateString(),
                            id: newplace.data().id,
                            image: newplace.data().image,
                            location: newplace.data().location,
                            longlat: newplace.data().longlat,
                            longitude: newplace.data().longlat.substring(22,31),
                            latitude: newplace.data().longlat.substring(5,14),
                            name: newplace.data().name,
                            photo: newplace.data().photo,
                            postid: newplace.data().postid,
                            review: newplace.data().review,
                            reviewed: newplace.data().reviewed
                        });
                this.setState({
                newplaces : newState
                });
            });
        });
    };

    render() {
        return (
            <MDBContainer fluid style={{ marginTop: "20px"}}>
            <MDBRow className="row d-flex ">
            {this.state.newplaces.map( (newplace) => {
                if(newplace.reviewed === 0)
                {
                    return(
                        <MDBCol md="4" sm="6" xs="12" className="mb-lg-0 mb-4" key={newplace.postid}>
                            <DisplayCard cardVal = {newplace} />
                        </MDBCol>
                    );
                }
            })}
            </MDBRow>
        </MDBContainer>
        );
    }
}


export default NewPlaces;