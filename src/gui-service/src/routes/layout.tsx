import { component$, Slot } from '@builder.io/qwik';

export default component$(() => {
    return (
        <>
            <nav></nav>
            <main>
                <Slot/>
            </main>
            <footer></footer>
        </>
    );
});
