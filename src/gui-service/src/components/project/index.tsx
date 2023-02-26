import { component$, useStylesScoped$ } from "@builder.io/qwik";
import projectCSS from "./index.css?inline";

/* Contains the object interface of a depth specific project. Such as the characters, contributers... */
export interface DepthProjectData{

}


/* Contains the object interface of a general summary of project. */
export interface SummaryProjectData {
    id: number,
    name: string,
    short_description: string,
    last_update: string
};

export const ProjectBox = component$((props: SummaryProjectData)=>{
    useStylesScoped$(projectCSS);
    return (
        <div class="project-box">
            <div class="project-name">{props.name}</div>
            <div class="project-description">{props.short_description}</div>
            <div class="project-extra">
                <div>Updated: {props.last_update}</div>
                <div>Created: {props.last_update}</div>
                <div>Owner: Mohido</div>
            </div>
        </div>
    );
});