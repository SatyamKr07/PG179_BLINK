import React, {Component} from "react";
import { MDBContainer, MDBRow, MDBCol, MDBBtn, MDBInput } from 'mdbreact';
import  { firestore, storage } from "../../../firebase";
import history from "../../../history";
const CreatePost = () => {
    const [title, setTitle] = React.useState('');
    const [budget, setBudget] = React.useState('');
    const [years, setYears] = React.useState('');
    //const [image, setImage] = React.useState(null);
    const [done, setDone] = React.useState(false);
    const [description, setDescription] = React.useState('');
    const allInputs = {imgUrl: ''}
    const [imageAsFile, setImageAsFile] = React.useState('')
    const [imageAsUrl, setImageAsUrl] = React.useState(allInputs)
   // const [url, setUrl] = React.useState('');
    //const [progress, setProgress] = React.useState(0);
    //const [error, setError] = React.useState(null);
    const handleImageAsFile = (e) => {
        const image = e.target.files[0]
        setImageAsFile(imageFile => (image))
    }

    const onChangeHandler = (e) => {
              const {name, value} = e.currentTarget;
              if(name === 'title') {
                  setTitle(value);
              }
              else if(name === 'description'){
               // this.setState({ [e.target.name]: e.target.value })
               setDescription(value);
              }
              else if(name === 'budget'){
                // this.setState({ [e.target.name]: e.target.value })
                setBudget(value);
               }
               else if(name === 'years'){
                // this.setState({ [e.target.name]: e.target.value })
                setYears(value);
               }
               else if(name === 'donetrue')
               {
                   setDone(true);
               } else if(name === 'donefalse')
               {
                   setDone(false);
               }
            };
    const handleFireBaseUpload = e => {
        e.preventDefault()
    console.log('start of upload')
    // async magic goes here...
    if(imageAsFile === '') {
      console.error(`not an image, the image file is a ${typeof(imageAsFile)}`)
    }
    const uploadTask = storage.ref(`/images/${imageAsFile.name}`).put(imageAsFile)
    //initiates the firebase side uploading 
    uploadTask.on('state_changed', 
    (snapShot) => {
      //takes a snap shot of the process as it is happening
      console.log(snapShot)
    }, (err) => {
      //catches the errors
      console.log(err)
    }, () => {
      // gets the functions from storage refences the image storage in firebase by the children
      // gets the download url then sets the image from firebase as the value for the imgUrl key:
      storage.ref('images').child(imageAsFile.name).getDownloadURL()
       .then(fireBaseUrl => {
         setImageAsUrl(prevObject => ({...prevObject, imgUrl: fireBaseUrl}) )
         
       })
    })
      }

        const addToDatabase = (event, title, url, description) => {
                event.preventDefault();
                var db = firestore;
                
                db.collection("WebPosts").add({
                    date: "02/08/2020", 
                    title: title,
                    image: url,
                    description: description,
                    budget: budget,
                    done: done,
                    years: years
                    
                })
                .then(function(docRef) {
                    console.log("Document written with ID: ", docRef.id);
                    history.push("/home");
                })
                .catch(function(error) {
                    //setError(error)
                    console.error("Error adding document: ", error);
                });
                
    };
    
    return (
                    <MDBContainer className="align-content-lg-center">
                      <MDBRow>
                        <MDBCol md="6">
                          <form >
                            <label htmlFor="defaultFormContactNameEx" className="grey-text">
                              Title
                            </label>
                            <input name="title" value={title} type="text" onChange = {onChangeHandler}  id="defaultFormContactNameEx" className="form-control" />
                            <br />
                            <label htmlFor="defaultFormContactEmailEx" className="grey-text">
                              Image
                            </label>
                            <input name="image" type="file" onChange={handleImageAsFile} id="defaultFormContactEmailEx" className="form-control" />
                            <MDBBtn color="success" type="submit" onClick={handleFireBaseUpload}>
                                        Upload
                            </MDBBtn>
                            <br />
                            <label htmlFor="defaultFormContactNameEx" className="grey-text">
                              Budget Utilized
                            </label>
                            <input name="budget" value={budget} type="text" onChange = {onChangeHandler}  id="defaultFormContactNameEx" className="form-control" />
                            <br />
                            <div>
                                <label>Has the project completed?</label>
                                <input type="checkbox" onChange = {onChangeHandler}  name="donetrue" />
                                <span>Yes</span>
                                <input type="checkbox" onChange = {onChangeHandler}  name="donefalse" />
                                <span>No</span>
                            </div>
                            <label htmlFor="defaultFormContactNameEx" className="grey-text">
                              Time taken for the project
                            </label>
                            <input name="years" value={years} type="text" onChange = {onChangeHandler}  id="defaultFormContactNameEx" className="form-control" />
                            <br />
                            <label htmlFor="defaultFormContactMessageEx" className="grey-text">
                              Description
                            </label>
                            <textarea name="description" value={description} onChange = {onChangeHandler} type="text" id="defaultFormContactMessageEx" className="form-control" rows="3" />
                            <div className="text-center mt-4">
                                      <MDBBtn color="success" onClick= {(event) => {addToDatabase(event, title, imageAsUrl.imgUrl, description)} }>
                                        Post
                                      </MDBBtn>
                                    </div>
                                  </form>
                                </MDBCol>
                              </MDBRow>
                            </MDBContainer>
                          );
} 


export default CreatePost;

