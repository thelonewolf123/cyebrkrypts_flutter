<script>
  import "codemirror/mode/python/python";

  import CodeMirror from "./index";
  import { onMount } from "svelte";
  const options = {
    mode: "python",
    lineNumbers: true,
    value: "",
  };
  let editor;

  function cursorMoved(event) {
    cursor_activity = true;
    console.log("cursor activity");
    // console.log(event.detail)
  }

  function changed(event) {
    window.code = editor.getValue();
    onCodeChange.postMessage(editor.getValue());
    // console.log(event.detail)
  }
</script>

<CodeMirror
  on:activity={cursorMoved}
  on:change={changed}
  bind:editor
  {options}
  class="editor"
/>

<style>
  :global(.editor) {
    font-size: 18px;
    width: 100%;
    height: 100vh;
  }
</style>
