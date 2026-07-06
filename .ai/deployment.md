# Deploy MkDocs su GitHub Pages

Questo documento definisce la procedura corretta per pubblicare il sito MkDocs del corso su GitHub Pages.

## Regole fondamentali

* Il sito generato deve essere pubblicato dal branch `gh-pages`.
* Il branch `main` non deve essere usato direttamente come sorgente Pages.
* La cartella `docs/` contiene i file Markdown sorgenti, non il sito generato.
* La cartella `site/` è il sito generato da MkDocs e deve essere pubblicata così com'è.
* La sorgente GitHub Pages deve essere impostata su `gh-pages` e `path: /`.

## Workflow di deploy corretto

Il file di workflow che pubblica il sito è `.github/workflows/mkdocs-deploy.yml`.
Deve:

1. Fare checkout del repository;
2. impostare Python;
3. installare le dipendenze;
4. eseguire `mkdocs build`;
5. pubblicare `site/` su `gh-pages`.

## Comandi di deploy manuale

Se occorre ripristinare manualmente la pubblicazione:

```bash
.venv/bin/mkdocs gh-deploy --clean --remote-name origin --branch gh-pages
```

Dopo aver creato il branch `gh-pages`, verificare o impostare la sorgente Pages:

```bash
gh api repos/quelo1972/c64-assembly-course/pages -X PUT -f source.branch=gh-pages -f source.path='/'
```

## Cosa fare se il sito remoto è ancora diverso da quello locale

1. Verificare che il branch `gh-pages` esista su GitHub.
2. Verificare che GitHub Pages sia configurato per usare `gh-pages` / `/`.
3. Controllare che `.github/workflows/mkdocs-deploy.yml` pubblichi `site/` su `gh-pages`.
4. Eseguire di nuovo il workflow o il comando manuale.
