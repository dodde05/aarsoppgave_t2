// FAQ page

const questions = [
    {q: "How do I download the game?", a: "Click the Game download link in the navigation bar, then click the big and obvious download button"},
    {q: "How do you play the game?", a: "'A' or left arrow and 'D' or right arrow to go left and right respectively. You can jump with spacebar and drop through platforms by tapping spacebar while holding 'S'"},
    {q: "q3", a: "a3"},
    {q: "q4", a: "a4"}
];

const questionsEl = document.getElementById("questions");

for (let qa of questions) {
    const qEl = document.createElement("h2");
    qEl.innerHTML = qa["q"];

    const aEl = document.createElement("p");
    aEl.innerHTML = qa["a"];

    questionsEl.appendChild(qEl);
    questionsEl.appendChild(aEl);
}