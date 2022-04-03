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
  let cursor_activity = false;
  onMount(() => {
    console.log("Editor: ", editor);
  });

  function cursorMoved(event) {
    cursor_activity = true;
    console.log("cursor activity");
    // console.log(event.detail)
  }

  function changed(event) {
    window.code = editor.getValue();
    console.log("changed");
    // console.log(event.detail)
  }
  function setCode(code) {
    options = {
      mode: "python",
      lineNumbers: true,
      value: code,
    };
  }
  window.setCode = setCode;
</script>

<CodeMirror
  on:activity={cursorMoved}
  on:change={changed}
  bind:editor
  {options}
  class="editor"
/>

<!-- <p>
  Cursor Activity: {cursor_activity}
</p>
<div>
  <button on:click={() => editor.execCommand("selectAll")}> Select All </button>
  <button on:click={() => editor.setCursor(0)}> Cursor at Start </button>
  <button on:click={() => editor.setCursor(editor.getValue().length)}>
    Cursor at End
  </button>
</div> -->
<style>
  :global(.editor) {
    font-size: 18px;
    width: 100%;
    height: 100vh;
  }
</style>
