import React from 'react';
import { Router, Route, Switch } from 'react-router-dom';
import Login from './views/Login/Login';
import Complaints from './views/Complaints/Complaints';
import ComplaintView from './views/ComplaintView/ComplaintView';
import Home from './views/Home/Home';
import NewPlaces from './views/NewPlaces/NewPlaces';
import NewPlaceView from './views/NewPlaceView/NewPlaceView';
import ViewPost from './views/Posts/ViewPost';
import ViewPosts from './views/Posts/ViewPosts/ViewPosts';
import Createpost from './views/Addposts/Createpost';
import Header from './Header';
import history from '../history';

const Application = () => {
    return (
        <div>
        <Router history={history}>
            <div>
                <Header/>
                <Switch>
                    <Route path = "/" exact component={Login} />
                    <Route path = "/home" exact component={Home} />
                    <Route path = "/newplaces" exact component={NewPlaces} />
                    <Route path = "/newplace/:id" exact component={NewPlaceView} />
                    <Route path = "/complaints" exact component={Complaints} />
                    <Route path = "/complaint/:id" exact component={ComplaintView} />
                    <Route path = "/createpost" exact component = {Createpost} />
                    <Route path = "/viewposts" exact component = {ViewPosts} />
                    <Route path = "/viewposts/:id" exact component = {ViewPost} />
                </Switch>
            </div>
        </Router>
    </div>
    );
}

export default Application;