# Tóm tắt kiến thức Machine Learning 

![alt text](<NotebookLM Mind Map (6).png>)

![alt text](<NotebookLM Mind Map (5).png>)

## I. Giới thiệu chung về Machine Learning (ML)

![alt text](<assets\NotebookLM Mind Map (5).png>)

1.  **Định nghĩa:**
    * Học máy là một lĩnh vực của trí tuệ nhân tạo (AI).
    * Cho phép máy tính "học" từ dữ liệu mà không cần được lập trình một cách tường minh cho từng tác vụ cụ thể.
    * Mục tiêu: Xây dựng các mô hình có khả năng dự đoán hoặc đưa ra quyết định dựa trên dữ liệu đầu vào.
2.  **Các thành phần chính của một bài toán ML:**
    * **Dữ liệu (Data):** Tập hợp các mẫu quan sát, mỗi mẫu có thể bao gồm các đặc trưng (features) và nhãn (labels - trong học có giám sát).
    * **Tác vụ (Task):** Mục tiêu cần đạt được (ví dụ: phân loại, hồi quy, phân cụm).
    * **Mô hình (Model):** Cấu trúc toán học mà máy tính học được từ dữ liệu để thực hiện tác vụ.
    * **Hàm mất mát (Loss Function):** Đo lường sự sai khác giữa dự đoán của mô hình và giá trị thực tế.
    * **Thuật toán học (Learning Algorithm):** Quy trình tối ưu hóa các tham số của mô hình để giảm thiểu hàm mất mát.
3.  **Các loại hình học máy chính:**
    * Học có giám sát (Supervised Learning)
    * Học không có giám sát (Unsupervised Learning)
    * Học củng cố (Reinforcement Learning)

## II. Học Có Giám Sát (Supervised Learning)
* **Đặc điểm:** Dữ liệu huấn luyện bao gồm cả đầu vào (features) và đầu ra mong muốn (labels).
* **Mục tiêu:** Học một hàm ánh xạ từ đầu vào đến đầu ra.

1.  **Bài toán Phân loại (Classification):**
    * Đầu ra là một nhãn rời rạc (category).
    * **Các thuật toán tiêu biểu (dựa trên slide của bạn):**
        * **Perceptron Learning Algorithm:**
            * Mô hình tuyến tính cho phân loại nhị phân.
            * Cập nhật trọng số dựa trên các điểm bị phân loại sai.
            * Điều kiện hội tụ: dữ liệu phải phân tách tuyến tính.
        * **K-Nearest Neighbors (KNN):**
            * Thuật toán "lười học" (lazy learning).
            * Phân loại một điểm dữ liệu mới dựa trên nhãn của k láng giềng gần nhất trong không gian đặc trưng.
            * Cần chọn giá trị k và thước đo khoảng cách phù hợp.
        * **Support Vector Machine (SVM):**
            * Tìm siêu phẳng phân cách tối ưu (optimal hyperplane) giữa các lớp.
            * Tối đa hóa lề (margin) giữa siêu phẳng và các điểm dữ liệu gần nhất (support vectors).
            * **Linear SVM:** Cho dữ liệu phân tách tuyến tính.
            * **Soft Margin SVM:** Cho phép một số điểm bị phân loại sai hoặc nằm trong lề, xử lý dữ liệu nhiễu hoặc không hoàn toàn phân tách tuyến tính (sử dụng biến bù $\xi_n$ và tham số C).
            * **Kernel SVM (Kernel Trick):** Ánh xạ dữ liệu lên không gian nhiều chiều hơn để tìm siêu phẳng phân cách khi dữ liệu không phân tách tuyến tính trong không gian gốc. Các kernel phổ biến: Linear, Polynomial, Radial Basis Function (RBF), Sigmoid.
        * **Binary Classifiers for Multi-class Classification:**
            * **One-vs-Rest (One-vs-All - OvA):** Huấn luyện N bộ phân loại nhị phân cho N lớp. Mỗi bộ phân loại quyết định một điểm có thuộc lớp đó hay không.
            * **One-vs-One (OvO):** Huấn luyện N(N-1)/2 bộ phân loại nhị phân cho mỗi cặp lớp. Quyết định cuối cùng dựa trên bỏ phiếu đa số.
            * (Các phương pháp khác như Hierarchical, Binary coding cũng được đề cập trong slide).
        * **Artificial Neural Network (ANN) - Multi-layer Perceptron (MLP) cho phân loại:** (Sẽ được đề cập chi tiết hơn trong phần Deep Learning nhưng cũng là một thuật toán học có giám sát).
        * **Softmax Regression (cho Multi-class):**
            * Là một dạng tổng quát hóa của Logistic Regression cho bài toán nhiều lớp.
            * Tính toán xác suất một mẫu thuộc về mỗi lớp.
            * Thường được sử dụng làm lớp output trong các mạng nơ-ron cho bài toán phân loại đa lớp.

2.  **Bài toán Hồi quy (Regression):**
    * Đầu ra là một giá trị liên tục.
    * **Các thuật toán tiêu biểu (dựa trên slide của bạn):**
        * **Linear Regression (Hồi quy tuyến tính):**
            * Mô hình hóa mối quan hệ tuyến tính giữa biến đầu vào (độc lập) và biến đầu ra (phụ thuộc).
            * **Simple Linear Regression:** Một biến độc lập ($y = w_0 + w_1x$).
            * **Multiple Linear Regression:** Nhiều biến độc lập ($y = w_0 + w_1x_1 + ... + w_px_p$).
            * Tìm các hệ số $w$ bằng phương pháp bình phương tối thiểu (Least Squares Method) - ví dụ: Normal Equation.
        * **K-Nearest Neighbors (KNN) cho hồi quy:**
            * Dự đoán giá trị cho một điểm mới bằng cách lấy trung bình (hoặc trung vị) giá trị của k láng giềng gần nhất.
        * **ANN/MLP cho hồi quy.**

3.  **Đánh giá mô hình trong học có giám sát:**
    * **Phân loại:** Accuracy, Precision, Recall, F1-score, Confusion Matrix, ROC Curve, AUC.
    * **Hồi quy:** Mean Squared Error (MSE), Root Mean Squared Error (RMSE), Mean Absolute Error (MAE), R-squared.
    * **Kỹ thuật:** Cross-validation (để đánh giá độ tổng quát hóa của mô hình).

4.  **Các vấn đề thường gặp:**
    * **Overfitting (Quá khớp):** Mô hình hoạt động tốt trên tập huấn luyện nhưng kém trên tập kiểm thử (dữ liệu mới).
        * Nguyên nhân: Mô hình quá phức tạp, dữ liệu huấn luyện ít.
        * Giải pháp: Đơn giản hóa mô hình, thêm dữ liệu, data augmentation, regularization (L1, L2), dropout (trong NNs), early stopping.
    * **Underfitting (Dưới khớp):** Mô hình hoạt động kém trên cả tập huấn luyện và tập kiểm thử.
        * Nguyên nhân: Mô hình quá đơn giản, không nắm bắt được quy luật của dữ liệu.
        * Giải pháp: Sử dụng mô hình phức tạp hơn, thêm đặc trưng, giảm regularization.
    * **Vanishing/Exploding Gradients (trong NNs):** Vấn đề gradient quá nhỏ hoặc quá lớn trong quá trình lan truyền ngược, gây khó khăn cho việc huấn luyện.

## III. Học Không Có Giám Sát (Unsupervised Learning)
* **Đặc điểm:** Dữ liệu huấn luyện chỉ bao gồm đầu vào (features), không có nhãn (labels).
* **Mục tiêu:** Khám phá cấu trúc tiềm ẩn trong dữ liệu.

1.  **Bài toán Phân cụm (Clustering):**
    * Nhóm các điểm dữ liệu tương tự nhau vào cùng một cụm.
    * **K-Means Clustering:**
        * Thuật toán phân hoạch (partitional clustering).
        * Cần xác định trước số lượng cụm (k).
        * Các bước: Khởi tạo k tâm cụm ngẫu nhiên -> Gán mỗi điểm vào cụm có tâm gần nhất -> Cập nhật lại tâm cụm bằng trung bình các điểm trong cụm -> Lặp lại cho đến khi hội tụ.
        * Vấn đề: Nhạy cảm với việc khởi tạo tâm ban đầu, cần chọn k phù hợp (ví dụ: Elbow method, Silhouette analysis).
        * Ứng dụng: Phân đoạn khách hàng, nén ảnh.

2.  **Bài toán Giảm chiều dữ liệu (Dimensionality Reduction):** (Không thấy đề cập nhiều trong slide của bạn nhưng là một phần quan trọng của học không giám sát)
    * Giảm số lượng đặc trưng mà vẫn giữ được thông tin quan trọng.
    * Ví dụ: Principal Component Analysis (PCA).

## IV. Học Củng Cố (Reinforcement Learning)
* **Đặc điểm:** Tác nhân (agent) học cách hành động trong một môi trường (environment) để tối đa hóa một phần thưởng (reward) tích lũy theo thời gian.
* **Các thành phần chính:**
    * **Agent:** Thực thể đưa ra quyết định.
    * **Environment:** Thế giới mà agent tương tác.
    * **State (s):** Tình trạng hiện tại của môi trường.
    * **Action (a):** Hành động mà agent thực hiện.
    * **Reward (r):** Tín hiệu phản hồi từ môi trường sau một hành động.
    * **Policy ($\pi$):** Chiến lược mà agent sử dụng để chọn hành động dựa trên state.
    * **Value Function (V, Q):** Ước lượng "giá trị" của một state hoặc một cặp state-action.
* **Q-Learning:**
    * Là một thuật toán học củng cố không phụ thuộc mô hình (model-free).
    * Học một hàm Q-value (quality) $Q(s, a)$, là phần thưởng kỳ vọng khi thực hiện hành động $a$ tại trạng thái $s$ và sau đó tuân theo chính sách tối ưu.
    * Công thức cập nhật Q-value: $Q(s, a) \leftarrow (1-\alpha)Q(s,a) + \alpha [r + \gamma \max_{a'} Q(s', a')]$
        * $\alpha$: learning rate.
        * $\gamma$: discount factor.
    * Sử dụng bảng Q-table để lưu trữ các giá trị Q.
    * Thăm dò (exploration) vs. Khai thác (exploitation).

## V. Các khái niệm bổ sung (Dựa trên slide)
* **Đặc trưng (Features):** Các thuộc tính đầu vào của dữ liệu.
* **Chuẩn hóa đặc trưng (Feature Scaling/Normalization):** Đưa các đặc trưng về cùng một thang đo.
* **Hàm kích hoạt (Activation Function) trong ANN:** Sigmoid, Tanh, ReLU, Leaky ReLU, ELU, Swish, SERLU, SELU (được đề cập trong slide ANN).
* **Lan truyền ngược (Backpropagation) trong ANN:** Thuật toán để tính toán gradient của hàm mất mát theo các trọng số của mạng.
* **Dropout (trong ANN):** Kỹ thuật regularization, ngẫu nhiên bỏ qua một số nơ-ron trong quá trình huấn luyện để tránh overfitting.
* **Data Augmentation:** Kỹ thuật tăng cường dữ liệu huấn luyện bằng cách tạo ra các biến thể của dữ liệu gốc (ví dụ: xoay ảnh, lật ảnh, thay đổi cường độ RGB).
* **Early Stopping:** Kỹ thuật dừng quá trình huấn luyện khi hiệu suất trên tập validation bắt đầu giảm để tránh overfitting.
* **Các loại Gradient Descent:** Batch GD, Stochastic GD (SGD), Mini-batch GD.
* **Momentum (trong GD):** Giúp thuật toán GD vượt qua các điểm cực tiểu cục bộ và tăng tốc độ hội tụ.
* **Weight Decay (L2 Regularization):** Thêm một thành phần vào hàm mất mát để phạt các trọng số lớn, giúp tránh overfitting.
