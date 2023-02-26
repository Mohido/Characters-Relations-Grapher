import { component$, useStore, useStylesScoped$ } from "@builder.io/qwik";
import Menu from "~/components/menu"
import Profile from "~/components/profile";
import { ProjectBox } from "~/components/project";
import Search from "~/components/search";
import contentCSS from "./index.css?inline"

export default component$((props)=>{
    
    useStylesScoped$(contentCSS);


    const projectsList = [
        {id:1, name: "project Alpha", short_description: "just a simple project", last_update:"10/Feb/3030"},
        {id:2, name: "Best Game", short_description: "just a simple project", last_update:"10/Feb/3030"},
        {id:3, name: "Long Very Best Game just very very very long d", short_description: "just very very very long descript a simple project just very very very long descript a simple project just very very very long descript a simple project just very very very long descript a simple project  just very very very long descript a simple project", last_update:"10/Feb/3030"},
        {id:4, name: "project Alpha", short_description: "just a simple project", last_update:"10/Feb/3030"},
        {id:5, name: "Best", short_description: "just a simple project", last_update:"10/Feb/3030"}
    ]


    return (
        <div>
            <Menu></Menu>
            <Profile></Profile>
            <Search></Search>
            <div class="projects-container">
                <h1 class="projects-header">Current Projects</h1>
                <div class="projects-content">
                {
                    projectsList.map((el)=>{
                        return <ProjectBox key={el.id} id={el.id} name={el.name} short_description={el.short_description} last_update={el.last_update}/>
                    })
                }
                </div>
            </div>
           
            

        </div>
    
    )
});

