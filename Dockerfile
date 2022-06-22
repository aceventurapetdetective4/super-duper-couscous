FROM ubuntu:jammy
COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip python3 python3-pip

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.zip" -O Goi5.1.bin.zip 

RUN wget --no-check-certificate "https://zipproth.de/Brainfish/Cerebellum_Light_3Merge_200916.zip" -O Cerebellum_Light_3Merge_200916.bin.zip
RUN unzip Cerebellum_Light_3Merge_200916.bin.zip && rm Cerebellum_Light_3Merge_200916.bin.zip
RUN mv Cerebellum_Light_3Merge_200916.bin_* engines/Cerebellum_Light_3Merge_200916.bin && chmod +x engines/Cerebellum_Light_3Merge_200916.bin

RUN mv config.yml.default config.yml
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_modern.zip -O stockfish.zip
RUN unzip stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Add the "--matchmaking" flag to start the matchmaking mode.
CMD python3 user_interface.py --non_interactive
