import React, { Component } from "react";
import DisplayCard from "./DisplayCard/DisplayCard";
import {  MDBRow, MDBCol,  MDBContainer } from "mdbreact";
import { firestore } from "../../../firebase";
class Complaints extends Component {
    constructor(props) {
        super(props);
        this.state = {
            complaints : []
        };
    };
    componentDidMount() {
                var db = firestore;
                db.collection("BroadGeneral").get().then((snapshot) => {
                    const newState = [];
                    snapshot.forEach((complaint) => {
                       // console.log(`${complaint.id} => ${complaint.data().name}`);
                        newState.push({
                                    date: complaint.data().date.toDate().toDateString(),
                                    ghatid: complaint.data().ghatid,
                                    id: complaint.data().id,
                                    image: complaint.data().image,
                                    //location: complaint.data().location,
                                    latitude: complaint.data().latitude,
                                    longitude: complaint.data().longitude,
                                    name: complaint.data().name,
                                    photo: complaint.data().photo,
                                    postid: complaint.data().postid,
                                    rating: complaint.data().rating,
                                    review: complaint.data().review,
                                    upvotes: complaint.data().upvotes
                                });
                        this.setState({
                        complaints : newState
                        });
                    });
                });
            };
  render () {
    return (
        <MDBContainer fluid style={{ marginTop: "20px"}}>
            <MDBRow className="row d-flex ">
            {this.state.complaints.map( (complaint) => {
                return(
                    <MDBCol md="4" sm="6" xs="12" className="mb-lg-0 mb-4" key={complaint.postid}>
                        <DisplayCard cardVal = {complaint} />
                    </MDBCol>
                );
            })}
            </MDBRow>
        </MDBContainer>
      );
  };
 
};

export default Complaints;