# Tóm tắt kiến thức Deep Learning

## I. Giới thiệu Deep Learning (DL)
1.  **Định nghĩa:**
    * Là một nhánh của Machine Learning dựa trên Artificial Neural Networks (ANNs) với nhiều lớp (deep architectures).
    * Các lớp này cho phép mô hình học các biểu diễn dữ liệu (features) ở nhiều mức độ trừu tượng khác nhau.
2.  **Sự khác biệt với ML truyền thống:**
    * **Feature Learning:** DL có khả năng tự động học các đặc trưng hữu ích từ dữ liệu thô, trong khi ML truyền thống thường yêu cầu feature engineering thủ công.
    * **Khả năng xử lý dữ liệu lớn và phức tạp:** DL thường hoạt động tốt với lượng dữ liệu lớn và các loại dữ liệu phi cấu trúc (ảnh, văn bản, âm thanh).
3.  **Tại sao Deep Learning lại hiệu quả?**
    * Khả năng mô hình hóa các mối quan hệ phi tuyến phức tạp.
    * Học biểu diễn phân cấp (hierarchical feature representation).
    * Sự phát triển của phần cứng (GPU) và lượng dữ liệu lớn.

## II. Artificial Neural Networks (ANNs) - Nền tảng của DL
* (Nhiều nội dung đã được đề cập trong phần Machine Learning, ở đây tập trung vào các khía cạnh liên quan đến DL)
1.  **Cấu trúc cơ bản:**
    * **Input Layer:** Nhận dữ liệu đầu vào.
    * **Hidden Layers:** Các lớp trung gian thực hiện tính toán và học biểu diễn. Mạng "deep" khi có nhiều hidden layers.
    * **Output Layer:** Đưa ra kết quả dự đoán.
    * **Neurons (Units):** Các đơn vị tính toán cơ bản trong mỗi lớp.
    * **Weights & Biases:** Các tham số của mô hình được học trong quá trình huấn luyện.
2.  **Activation Functions (Hàm kích hoạt):**
    * Đưa tính phi tuyến vào mô hình.
    * Ví dụ: Sigmoid, Tanh, **ReLU (Rectified Linear Unit)** và các biến thể (Leaky ReLU, ELU, PReLU) - ReLU rất phổ biến trong DL do khắc phục được vấn đề vanishing gradient ở một mức độ nào đó và tính toán hiệu quả.
    * Softmax: Thường dùng ở output layer cho bài toán phân loại đa lớp.
3.  **Huấn luyện ANNs:**
    * **Forward Propagation:** Tính toán đầu ra của mạng từ input.
    * **Loss Function:** Đo lường lỗi (ví dụ: Cross-Entropy cho phân loại, MSE cho hồi quy).
    * **Backpropagation:** Lan truyền ngược lỗi để tính gradient của loss function theo các weights.
    * **Gradient Descent (và các biến thể):** SGD, Mini-batch GD, Adam, RMSprop, Adagrad - các thuật toán tối ưu hóa để cập nhật weights.
4.  **Các vấn đề trong huấn luyện mạng sâu:**
    * **Vanishing Gradients:** Gradient trở nên rất nhỏ khi lan truyền qua nhiều lớp, làm chậm hoặc dừng quá trình học của các lớp đầu.
    * **Exploding Gradients:** Gradient trở nên rất lớn, gây mất ổn định cho quá trình học. (Giải pháp: Gradient Clipping).
    * **Overfitting:** (Xem lại phần ML). Giải pháp trong DL: Regularization (L1, L2), Dropout, Data Augmentation, Early Stopping, Batch Normalization.

## III. Convolutional Neural Networks (CNNs / ConvNets)
* **Đặc điểm:** Kiến trúc mạng nơ-ron chuyên biệt để xử lý dữ liệu có cấu trúc dạng lưới (grid-like topology), ví dụ như hình ảnh.
* **Lấy cảm hứng từ:** Hệ thống thị giác của động vật.
* **Ưu điểm so với ANNs truyền thống cho ảnh:**
    * **Local Connectivity (Kết nối cục bộ):** Mỗi nơ-ron trong lớp convolution chỉ kết nối với một vùng nhỏ (receptive field) của lớp trước. Giúp giảm số lượng tham số và nắm bắt các đặc trưng cục bộ.
    * **Shared Weights (Chia sẻ trọng số):** Các kernel (filters) được áp dụng trên toàn bộ ảnh, giúp phát hiện cùng một đặc trưng ở các vị trí khác nhau (translation invariance) và giảm mạnh số lượng tham số.
    * **Hierarchical Feature Learning:** Các lớp đầu học các đặc trưng đơn giản (cạnh, góc), các lớp sau kết hợp chúng để học các đặc trưng phức tạp hơn (bộ phận, đối tượng).

1.  **Các lớp chính trong CNN:**
    * **Convolutional Layer (Lớp Tích chập):**
        * Thực hiện phép tích chập giữa input và các bộ lọc (kernels/filters) để tạo ra các feature maps.
        * **Kernel (Filter):** Một ma trận trọng số nhỏ, trượt qua input để phát hiện các đặc trưng cụ thể (ví dụ: cạnh, góc, màu sắc).
        * **Feature Map (Bản đồ đặc trưng):** Output của một kernel, cho thấy sự hiện diện của đặc trưng đó trên input.
        * **Parameters:** Kích thước kernel, stride (bước trượt), padding (thêm viền 0 vào input).
        * Thường theo sau bởi một hàm kích hoạt (ví dụ: ReLU).
    * **Pooling Layer (Lớp Gộp):**
        * Giảm kích thước không gian của feature maps, giúp giảm số lượng tham số, kiểm soát overfitting và tăng tính bất biến với các thay đổi nhỏ.
        * **Max Pooling:** Lấy giá trị lớn nhất trong một vùng.
        * **Average Pooling:** Lấy giá trị trung bình trong một vùng.
        * **Parameters:** Kích thước pooling window, stride.
    * **Fully Connected Layer (Lớp Kết nối Đầy đủ - FC Layer):**
        * Thường nằm ở cuối mạng CNN, sau các lớp Convolutional và Pooling.
        * Các nơ-ron kết nối đầy đủ với tất cả các nơ-ron ở lớp trước đó (giống như trong MLP).
        * Dùng để thực hiện tác vụ phân loại hoặc hồi quy dựa trên các đặc trưng đã được học.
        * Trước khi vào FC layer, feature maps thường được "flatten" (làm phẳng) thành một vector.
    * **Output Layer:**
        * Ví dụ: Softmax cho phân loại đa lớp.

2.  **Kiến trúc CNN tiêu biểu:**
    * Chuỗi các (Convolutional Layer -> Activation -> Pooling Layer) lặp lại nhiều lần.
    * Theo sau là một hoặc nhiều Fully Connected Layers.
    * Cuối cùng là Output Layer.
    * **Ví dụ (AlexNet - dựa trên slide của bạn):**
        * Thắng cuộc thi ImageNet LSVRC-2012.
        * Kiến trúc: 5 Convolutional Layers, 3 Fully-Connected Layers, Softmax output.
        * Sử dụng ReLU activation.
        * Sử dụng Overlapping Pooling.
        * Kỹ thuật giảm overfitting: Data Augmentation, Dropout.
        * Huấn luyện trên nhiều GPU.

3.  **Ứng dụng của CNN:**
    * Nhận dạng ảnh, phân loại ảnh (Image Classification).
    * Phát hiện đối tượng (Object Detection).
    * Phân đoạn ảnh (Image Segmentation).
    * Nhận dạng khuôn mặt.
    * Xử lý ngôn ngữ tự nhiên (NLP) cho văn bản (xem văn bản như một chuỗi 1D).

## IV. Recurrent Neural Networks (RNNs)
* **Đặc điểm:** Kiến trúc mạng nơ-ron được thiết kế để xử lý dữ liệu dạng chuỗi (sequential data), nơi thứ tự của các phần tử là quan trọng.
* **Cơ chế:** Có các kết nối vòng (recurrent connections) cho phép thông tin từ các bước thời gian trước đó được lưu giữ và ảnh hưởng đến việc xử lý ở các bước thời gian hiện tại và tương lai -> tạo ra "bộ nhớ" cho mạng.
* **State (Trạng thái ẩn - $h_t$):** Lưu trữ thông tin về những gì đã xảy ra trong chuỗi cho đến thời điểm hiện tại. $h_t = f_W(h_{t-1}, x_t)$.

1.  **Cấu trúc RNN cơ bản (Vanilla RNN):**
    * Cùng một tập trọng số (W) được sử dụng ở mỗi bước thời gian.
    * Hàm kích hoạt thường dùng: Tanh hoặc ReLU.
2.  **Quá trình "Unrolling" (Mở rộng theo thời gian):**
    * Để hình dung và huấn luyện, RNN thường được mở rộng thành một mạng feedforward sâu, với mỗi bước thời gian là một "lớp".
3.  **Backpropagation Through Time (BPTT):**
    * Thuật toán huấn luyện RNN, tương tự backpropagation nhưng lan truyền lỗi ngược theo cả các lớp và các bước thời gian.
4.  **Các vấn đề của RNN cơ bản:**
    * **Vanishing/Exploding Gradients:** Vấn đề này đặc biệt nghiêm trọng trong RNN khi xử lý các chuỗi dài, khiến mạng khó học được các phụ thuộc xa (long-term dependencies).
5.  **Ứng dụng của RNN:**
    * Xử lý ngôn ngữ tự nhiên (NLP): Language Modeling, Machine Translation, Sentiment Analysis, Speech Recognition.
    * Phân tích chuỗi thời gian.
    * Nhận dạng hành động trong video.

## V. Long Short-Term Memory (LSTM) Networks
* **Đặc điểm:** Một loại RNN đặc biệt, được thiết kế để giải quyết vấn đề vanishing gradient và học tốt hơn các phụ thuộc xa.
* **Cơ chế cốt lõi: Cell State và Gates.**
    * **Cell State ($C_t$):** "Đường cao tốc thông tin", cho phép thông tin truyền đi gần như không thay đổi qua nhiều bước thời gian. LSTM có khả năng thêm hoặc bớt thông tin vào cell state thông qua các cổng.
    * **Gates (Cổng):** Các cấu trúc mạng nơ-ron nhỏ (thường là một lớp sigmoid) điều khiển việc thông tin nào được phép đi qua.
        * **Forget Gate ($f_t$):** Quyết định thông tin nào từ cell state trước đó ($C_{t-1}$) sẽ bị loại bỏ.
            * $f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$
        * **Input Gate ($i_t$):** Quyết định thông tin mới nào từ input hiện tại ($x_t$) và hidden state trước đó ($h_{t-1}$) sẽ được lưu vào cell state.
            * $i_t = \sigma(W_i \cdot [h_{t-1}, x_t] + b_i)$
            * $\tilde{C}_t = \tanh(W_C \cdot [h_{t-1}, x_t] + b_C)$ (Candidate values)
        * **Cell State Update:** Cập nhật cell state cũ $C_{t-1}$ thành cell state mới $C_t$.
            * $C_t = f_t * C_{t-1} + i_t * \tilde{C}_t$
        * **Output Gate ($o_t$):** Quyết định phần nào của cell state sẽ được đưa ra làm output (hidden state $h_t$).
            * $o_t = \sigma(W_o \cdot [h_{t-1}, x_t] + b_o)$
            * $h_t = o_t * \tanh(C_t)$
6.  **Ưu điểm của LSTM:**
    * Khả năng ghi nhớ thông tin trong thời gian dài.
    * Xử lý hiệu quả các phụ thuộc xa.
7.  **Biến thể của LSTM:**
    * Gated Recurrent Unit (GRU) - một phiên bản đơn giản hơn LSTM.
8.  **Ứng dụng:** Tương tự RNN, nhưng thường cho kết quả tốt hơn với các chuỗi dài (ví dụ: dịch máy, sinh văn bản, nhận dạng giọng nói).

## VI. Các kiến trúc và khái niệm DL khác (Có thể mở rộng)
* **Autoencoders:** Mạng nơ-ron học cách nén (encode) input thành một biểu diễn ẩn và sau đó giải nén (decode) lại thành output gần giống input. Dùng cho giảm chiều dữ liệu, feature learning, sinh dữ liệu.
* **Generative Adversarial Networks (GANs):** Hệ thống gồm hai mạng (Generator và Discriminator) cạnh tranh với nhau để sinh ra dữ liệu mới giống thật.
* **Transformers (Attention is All You Need):** Kiến trúc rất thành công trong NLP, dựa trên cơ chế "attention" để nắm bắt mối quan hệ giữa các từ trong câu mà không cần các kết nối vòng như RNN/LSTM. (Ví dụ: BERT, GPT).
* **Transfer Learning:** Sử dụng một mô hình đã được huấn luyện trước trên một tập dữ liệu lớn (ví dụ: ImageNet) và tinh chỉnh (fine-tune) nó cho một tác vụ mới với tập dữ liệu nhỏ hơn.
