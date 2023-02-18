import { component$ } from "@builder.io/qwik";
import Menu from "~/components/menu"
import Profile from "~/components/profile";
import Search from "~/components/search";


export default component$((props)=>{
    
    return (
        <dev>
            <Menu></Menu>
            <Profile></Profile>
            <Search></Search>
        </dev>
    
    )
});

