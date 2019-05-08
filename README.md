# EEG and tensors
A utilizacao de ferramentas tensoriais para processamento do EEG e predicao de crises epiléticas é algo recorrente na literatura cientifica. O desenvolvimento/aprimoramento destas tecnicas faz parte da evolucao da analise deste tipo de exame, buscando antecipar e identificar os momentos que precedem uma crise, tendo em vista que o resultado de uma convulsao e justamente uma reacao de involuntaria de um conjunto de musculos, o que pode ocasionar lesoes e trazer mais transtornos ao doente.

- [x] Descrição do Conjunto de Dados
- [x] Centralização e Escalonamento
- [ ] Análise da Covariância
- [ ] PCA
- [ ] ALS

Deste modo, observamos o conjunto de dados do banco de dados do MIT, para vislumbrar o uso de tecnicas tensoriais e se for o caso, testar sua eficiencia e eficacia na solucao destes problemas.

Parte do DATASET está disponível em: https://physionet.org/pn6/chbmit/

Para os exemplos deste arquivo são utilizado o arquivo [chb01_03.edf](https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/functions/chb01_03.edf), que tem 23 canais, 921600 amostras e frequência de amostragem 256Hz. Ou seja, o exame tem duração de 1 hora.

## Centralização e Escalonamento
Os nossos sinais de EEG chegam com médias e desvio padrão diferentes, sem nenhuma padronização, o que dificulta a visualização e análise. Uma forma de resolver é parametrizando-os justamente em função da média e do desvio padrão de cada um deles.

Chamaremos os exames utilizados de <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;x" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;x" title="x" /></a> e o enésimo canal dele de <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;x_n" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;x_n" title="x_n" /></a>.

O sinal do canal 1 original é:

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/plot_01.png" width="500" >
</p>

Sendo o canal <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;x_1" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;x_1" title="x_1" /></a>, tomamos a média <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;\mu" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;\mu" title="\mu" /></a> e desvio padrão <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;\sigma" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;\sigma" title="\sigma" /></a>, o sinal parametrizado <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;\bar{x_1}" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;\bar{x_1}" title="\bar{x_1}" /></a> é dado por: <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;\bar{x_1}&space;=&space;\dfrac{x_1&space;-&space;\mu}{\sigma}" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;\bar{x_1}&space;=&space;\dfrac{x_1&space;-&space;\mu}{\sigma}" title="\bar{x_1} = \dfrac{x_1 - \mu}{\sigma}" /></a>.

Isso nós fornece um sinal com as mesmas características do original, porém com média nula e desvio padrão unitário, utilizando a função [center_scale.m](https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/functions/center_scale.m)

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/plot_02.png" width="500" >
</p>

## Análise da Covariância
Utilizando <a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\bg_white&space;\bar{x_1}" target="_blank"><img src="https://latex.codecogs.com/png.latex?\dpi{120}&space;\bg_white&space;\bar{x_1}" title="\bar{x_1}" /></a>, comparando cada canal na métrica de covariância e plotando a matriz resultante em um mapa de calor é obtido o seguinte resultado.

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/heatmap_01.png" width="500" >
</p>

Ainda é um pouco difícil de visualizar algo efetivo, mas é possível observar algumas tendências de correlação. Entretanto, talvez usar limiares de comparação, como por exemplo um mapa de calor para valores de covariância maiores que 0.7. Ou menos que -0.8, por exemplo, vamos ver se há canais com esse indícia de correlação com outros.

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/heatmap_02.png" width="500" >
</p>

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/heatmap_03.png" width="500" >
</p>

<p align="center">
<img src="https://github.com/processamentobio/eeg-and-tensors/blob/Rush-01/Abril/images/chb01_03.edf/screeplot_01.png" width="500" >
</p>
