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
            <a class="project-box-hoverer">
                <img src="/images/projects-placeholder-png.png" class="project-box-image"/>
                <div class="project-box-title">{props.name}</div>
                <div class="project-box-description">{props.short_description}
                    {/* <div>{props.short_description}</div> */}
                    {/* <div class="project-box-description-fade"></div> */}
                </div>
                
                <div class="project-box-extra-1">
                    <div>
                        <div>Updated</div>
                        <div>{props.last_update}</div>
                    </div>
                    <div>
                        <div>Owner</div>
                        <div>Mohido</div>
                    </div>
                </div>
            </a>
            

            <div class="project-box-extra-2" >
                <div title="Active Users">
                <i class="fa-solid fa-chart-line" ></i>
                    <span>2</span>
                </div>
                <div title="Characters Count">
                <i class="fa-solid fa-network-wired" ></i>
                    <span>15</span>
                </div>
                <div title="Project Collaborators">
                    <i class="fa-solid fa-user" ></i>
                    <span>1412</span>
                </div>
                <div title="Import/Download Project">
                    <button>
                        <i class="fa-solid fa-download" ></i>
                    </button>
                </div>

            </div>

        </div>
    );
});