FROM nvcr.io/nvidia/pytorch:23.04-py3

RUN apt-get update  && apt-get install -y git python3-virtualenv wget 

WORKDIR /workspace

#RUN pip uninstall -y flash-attn
#RUN pip uninstall -y transformer-engine
#RUN pip install git+https://github.com/NVIDIA/TransformerEngine.git@stable

RUN pip install transformers
RUN pip install sentencepiece
RUN pip install datasets 
RUN pip install accelerate 
RUN pip install bitsandbytes 
RUN pip install einops 
RUN pip install sentence-transformers 
RUN pip install InstructorEmbedding 
RUN pip install peft 
RUN pip install trl 
RUN pip install rouge_score 
RUN pip install evaluate 
RUN pip install optimum
RUN pip install dash
RUN pip install ipykernel
RUN pip install -U pip setuptools wheel
RUN pip install -U 'spacy[cuda-autodetect]'
RUN python -m spacy download en_core_web_sm
RUN pip install fastapi
RUN pip install pydantic
RUN pip install uvicorn

#RUN git clone https://github.com/facebookresearch/faiss.git faiss_git && cd faiss_git && \
#    cmake -B build . && \
#    make -C build -j swigfaiss && (cd build/faiss/python ; python setup.py build) && cd ..
#RUN printf '\nexport PYTHONPATH=$PYTHONPATH:"$(ls -d /home/user/faiss_git/build/faiss/python/build/lib*/)"\n' | sudo tee -a /etc/profile /etc/bash.bashrc

#RUN git clone https://github.com/decile-team/submodlib.git && cd submodlib && pip install . && cd ..
#RUN rm -rf submodlib

COPY ./instruction_tuner.py instruction_tuner.py
COPY t0_task_finetune.sh t0_task_finetune.sh
RUN chmod +x t0_task_finetune.sh

COPY ./config.yaml config.yaml

RUN apt-get -y install apt-utils sudo
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
RUN sudo apt-get install git-lfs


