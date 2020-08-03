import React, { Component } from 'react';
import DisplayCard from "./DisplayCard/DisplayCard";
import AddProjectDisplayCard from "./DisplayCard/AddProjectDisplayCard";
import {  MDBRow, MDBCol,  MDBContainer } from "mdbreact";
import { firestore } from "../../../../firebase";

class ViewPosts extends Component {
    constructor(props) {
        super(props);
        this.state = {
            projects : []
        };
    };

    componentDidMount(){
        var db = firestore;
        db.collection("WebPosts").get().then((snapshot) => {
            const newState = [];
            snapshot.forEach((project) => {
                //console.log(`${newplace.id} => ${newplace.data().name}`);
                newState.push({
                    budget: project.data().budget,
                    date: project.data().date,
                    description: project.data().description,
                    done: project.data().done,
                    image: project.data().image,
                    title: project.data().title,
                    years: project.data().years,
                    id: project.id
                });
                this.setState({
                projects : newState
                });
            });
        });
    };

    render() {
        return (
            <MDBContainer className="align-content-lg-center" fluid style={{ marginTop: "20px"}}>
                <MDBRow center style={{marginBottom: "20px"}}>
                    <h4 style={{textAlign: "center", fontWeight: 600, fontSize: "2rem"}}>ONGOING PROJECTS</h4>
                </MDBRow>
                <MDBRow className="row d-flex ">
                    <MDBCol md="4" sm="6" xs="12" className="mb-lg-0 mb-4">
                        <AddProjectDisplayCard />
                    </MDBCol>
                {this.state.projects.map( (project) => {
                    return (
                        <MDBCol md="4" sm="6" xs="12" className="mb-lg-0 mb-4" key={project.id}>
                            <DisplayCard cardVal = {project} />
                        </MDBCol>
                    );
                })}
                </MDBRow>
        </MDBContainer>
        );
    }
}


export default ViewPosts;