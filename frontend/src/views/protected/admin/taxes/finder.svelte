<script>
  import Loading from "../../../components/loading.svelte";
  import ShowTax from "./show/tax.svelte";
  import EditTax from "./edit/tax.svelte";
  import { TaxModel } from "../../../../lib/models/tax";

  export let taxId;
  export let graphqlClient;
  export let show = true;

  let tax = TaxModel().findOne(graphqlClient, taxId);

  $: tax = TaxModel().findOne(graphqlClient, taxId);
</script>

{#await $tax}
  <Loading />
{:then result}
  {#if show}
    <ShowTax tax={result.data.taxes[0]} {graphqlClient} />
  {:else}
    <EditTax
      tax={result.data.taxes[0]}
      categories={result.data.categories}
      {graphqlClient} />
  {/if}
{:catch error}
  Error: {error}
{/await}
