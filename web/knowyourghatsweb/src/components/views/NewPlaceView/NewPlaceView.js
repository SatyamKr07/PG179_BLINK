import React from 'react';
import { MDBContainer, MDBMask, MDBCard, MDBCardBody, MDBIcon, MDBView, MDBBtn } from "mdbreact";
import Map from "./Map";

const NewPlaceView = (props) => {
    const ob = props.location.myCustomProps;
    //console.log(ob);
    return (
        <MDBContainer className="align-content-lg-center" style={{ marginTop: "20px"}}>
            <MDBCard className="w-100">
                <MDBCardBody>
                    <div style={{marginTop: "20px",marginBottom: "20px", marginLeft: "40px"}}>
                        <span className="grey-text pr-3" style={{marginRight: "6px"}}>
                            <MDBIcon icon="user" className="grey-text pr-2"/>
                            {ob.name}
                        </span>              
                        <span className="grey-text pr-3" style={{marginRight: "6px"}}>
                            <MDBIcon icon="clock" className="grey-text pr-2" />
                            10/03/2020
                        </span>
                    </div>
                    <MDBView hover className="rounded mb-4" waves>
                        <img
                            style={{height: "70vh", width: "90%", marginTop: "10px"}}
                            className="img-fluid mx-auto d-block text-center"
                            src={ob.image}
                            alt=""
                        />
                        <MDBMask overlay="white-slight" />
                    </MDBView>
                    <div className="text-justify" style={{marginTop: "10px", marginLeft: "40px", marginRight: "40px"}}>
                        <p className="dark-grey-text">
                            {ob.review}
                        </p>                                                             
                    </div> 
                    <p className="text-center" style={{marginTop: '30px', marginLeft: "40px"}}>
                        <strong>
                            Location MapView
                        </strong>
                    </p>    
                    <div style={{position: 'relative', marginLeft: "40px"}}>
                        <Map style={{position: 'relative'}}/>
                    </div>
                    <div className="text-center">
                    <MDBBtn style={{marginRight: "15px"}} className="success">Accept</MDBBtn>
                    <MDBBtn  style={{marginLeft: "15px"}} color="danger">Decline</MDBBtn>
                    </div>
                    
                </MDBCardBody>
            </MDBCard>
        </MDBContainer>
    );
};

export default NewPlaceView;