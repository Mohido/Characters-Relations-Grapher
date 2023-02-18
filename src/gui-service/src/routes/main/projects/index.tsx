import { component$ } from "@builder.io/qwik";
import Menu from "~/components/menu"
import Profile from "~/components/profile";


export default component$((props)=>{
    
    return (
        <dev>
            <Menu></Menu>
            <Profile></Profile>
        </dev>
    
    )
});

