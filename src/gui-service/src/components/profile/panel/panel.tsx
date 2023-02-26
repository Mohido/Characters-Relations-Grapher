import { component$, useBrowserVisibleTask$, useContext, useSignal, useStylesScoped$ } from "@builder.io/qwik";
import { ProfileContextID, ProfileContext } from "../context";
import profileCSS from "./panel.css?inline";

export const ProfilePanel = component$(()=>{
    const profileContext : ProfileContext = useContext(ProfileContextID);
    const profileSignal = useSignal<Element>();

    useStylesScoped$(profileCSS);
    useBrowserVisibleTask$(({track})=>{
        track(()=>profileContext.open);
        const profile = profileSignal.value as HTMLElement;
        if(profileContext.open){
            profile.classList.add("profile-panel-visible");
        }else{
            profile.classList.remove("profile-panel-visible");
        }  
    })

    return (
        <div class="profile-panel" ref={profileSignal}>
            <h1>Hello from the profile popup</h1>
        </div>
    )
});