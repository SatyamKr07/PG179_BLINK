import React from 'react';
import { MDBContainer, MDBMask, MDBCard, MDBCardBody, MDBIcon, MDBView, MDBBtn } from "mdbreact";
import { firestore } from "../../../firebase";


const NewPlaceView = (props) => {
    const ob = props.location.myCustomProps;
    //console.log(ob);
    const db = firestore;
    return (
        <MDBContainer className="align-content-lg-center" style={{ marginTop: "20px"}}>
            <MDBCard className="w-100">
                <MDBCardBody>
                <h4 style={{marginLeft: "45px", fontWeight: 600}}>{ob.title}</h4>  
                    <div style={{marginTop: "20px",marginBottom: "20px", marginLeft: "45px"}}>
                        <span className="grey-text pr-3" style={{marginRight: "6px"}}>
                            <MDBIcon far icon="calendar-check" className="grey-text pr-2" />
                            {ob.date}
                        </span>      
                        <span className="grey-text pr-3" style={{marginRight: "6px"}}>
                            <MDBIcon icon="money-bill" className="grey-text pr-2"/>
                            {ob.budget}
                        </span>     
                        <span className="grey-text pr-3" style={{marginRight: "6px"}}>
                            <MDBIcon icon="clock" className="grey-text pr-2" />
                            {ob.years}
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
                    <div className="text-justify" style={{marginTop: "10px", marginLeft: "45px", marginRight: "45px", fontSize: "1.1rem"}}>
                        <p className="dark-grey-text">
                            {ob.description}
                        </p>                                                             
                    </div>                     
                </MDBCardBody>
            </MDBCard>
        </MDBContainer>
    );
};

export default NewPlaceView;