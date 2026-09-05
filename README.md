# wesnoth-2077

Layer di agentizzazione per [Wesnoth](https://github.com/wesnoth/wesnoth), estratto dal fork
`mattiabestiaccia/wesnoth-2077` (branch `agent/wesnoth-2077`) e reso repository autonomo.

## Cosa c'è qui

- `agent-layer/` — il layer vero e proprio: build in container, smoke test headless,
  plugin Lua di esempio, strategia sul memory footprint, misura dei profili dati
  (full vs light), divergence ledger.
- `docs/okf/` — documentazione di Wesnoth in Open Knowledge Format v0.1.
- `utils/CI/check_okf.sh` — validatore OKF per la CI.
- `upstream-patches/` — le tre modifiche a file di Wesnoth (`README.md`,
  `CONTRIBUTING.md`, `.github/workflows/ci-main.yml`) che non hanno senso fuori
  dall'albero originale, conservate come patch applicabile.

## Perché non è più un fork

Dentro un fork i commit non compaiono nel grafo dei contributi
([docs GitHub](https://docs.github.com/en/account-and-profile/reference/profile-contributions-reference):
*«the commits were made in a standalone repository, not a fork»*), e il fork trascinava
4,2 GB di albero di gioco per ~1.500 righe di lavoro proprio.

Ticket di origine: `BRU-43-*`.
