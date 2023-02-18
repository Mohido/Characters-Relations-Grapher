import { component$, useContextProvider , useStore} from "@builder.io/qwik";
import { ProfileButton } from "./button/button";
import { ProfilePanel } from "./panel/panel";
import {ProfileContextID, ProfileContext} from "./context";


export default component$(()=>{
    useContextProvider(ProfileContextID, useStore<ProfileContext>({open:false}));

    return (
        <div style="position:relative;">
            <ProfilePanel></ProfilePanel>
            <ProfileButton></ProfileButton>
        </div>
    )
})