FROM sharelatex/sharelatex:5.3.1

WORKDIR /overleaf

RUN tlmgr option repository https://ctan.org/tex-archive/systems/texlive/tlnet && \
    tlmgr update --self --all && \
    tlmgr install scheme-full && \
    tlmgr path add

RUN git clone https://github.com/yu-i-i/overleaf-cep.git overleaf-cep && \
    mv overleaf-cep/services/web/modules/track-changes services/web/modules/track-changes && \
    rm -rf overleaf-cep && \
    sed -i "/moduleImportSequence:/a 'track-changes'," services/web/config/settings.defaults.js && \
    sed -i 's/trackChangesAvailable: false/trackChangesAvailable: true/g' services/web/app/src/Features/Project/ProjectEditorHandler.js

ENTRYPOINT ["/sbin/my_init"]
