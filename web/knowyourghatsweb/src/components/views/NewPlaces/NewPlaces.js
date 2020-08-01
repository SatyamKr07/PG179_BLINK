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
                            id: newplace.data().id,
                            image: newplace.data().image,
                            location: newplace.data().location,
                            name: newplace.data().name,
                            photo: newplace.data().photo,
                            postid: newplace.data().postid,
                            review: newplace.data().review
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
                return(
                    <MDBCol md="4" sm="6" xs="12" className="mb-lg-0 mb-4" key={newplace.id}>
                        <DisplayCard cardVal = {newplace} />
                    </MDBCol>
                );
            })}
            </MDBRow>
        </MDBContainer>
        );
    }
}


export default NewPlaces;