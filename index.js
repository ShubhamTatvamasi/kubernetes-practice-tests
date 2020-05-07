const author = "https://katacoda.com/embed/mmumshad2/"
const flags = "?embed&url&host=kodekloud.com&nonce="
let nonce = ""

async function generateNonce() {
  let response = await fetch("https://katacoda.com/api/embed/nonce");
  let new_nonce = await response.text();
  nonce = new_nonce
}

async function generateUrl() {
  await generateNonce();

  let current_url = window.location.href
  let new_url = new URL(current_url);
  let scenario = await new_url.searchParams.get("scenario");

  let scenario_url = author + scenario + flags + nonce

  window.location = scenario_url
}

generateUrl()
